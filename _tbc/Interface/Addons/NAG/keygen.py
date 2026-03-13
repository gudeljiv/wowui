"""
NAG Key Generator
Replicates the key validation logic from Utils.lua / StringUtil.lua
"""

import base64
import time
import re
import sys


def compute_hash(input_string: str) -> str:
    """
    Replicates ns.computeHash from Utils.lua:
      for each char: hashValue = rotate_left_32(hashValue + charByte, 5)
    Returns 8-char lowercase hex string.
    """
    hash_value = 0
    for char in input_string:
        hash_value = (hash_value + ord(char)) % 0x100000000
        hash_value = ((hash_value << 5) | (hash_value >> 27)) & 0xFFFFFFFF
    return format(hash_value, "08x")


def get_identifier(battle_tag: str) -> str:
    """
    Replicates StringUtil.GetBattleTagKeyIdentifier from StringUtil.lua
    Input:  "PlayerName#1234"
    Output: "PLAYERNAME#1234"
    """
    raw = battle_tag.strip()
    if not raw:
        return ""

    hash_pos = raw.find("#")
    if hash_pos >= 0:
        name_part = raw[:hash_pos]
        discr_part = raw[hash_pos + 1 :]
    else:
        name_part = raw
        discr_part = ""

    name_clean = re.sub(r"[^a-zA-Z0-9]", "", name_part).upper()
    discr_clean = re.sub(r"[^0-9]", "", discr_part)

    if len(name_clean) <= 2 and discr_clean:
        name_clean = discr_clean

    if discr_clean:
        return name_clean + "#" + discr_clean
    return name_clean


def effective_salt_for_hash(raw_key: str, salt: str) -> str:
    """
    Lua's decodeBase64 has a bug: trailing padding bits are left as literal
    '0' characters in the decoded output (gsub doesn't remove non-matching tail).

    For a raw_key of length N bytes:
      N % 3 == 0  ->  no extra chars
      N % 3 == 1  ->  4 extra '0' chars appended (4 padding bits)
      N % 3 == 2  ->  2 extra '0' chars appended (2 padding bits)

    Lua then trims part4 once if it ends with "00".
    This function returns what Lua will actually use as part4 when hashing.
    """
    extra = ["", "0000", "00"][len(raw_key) % 3]
    decoded_salt = salt + extra
    if decoded_salt.endswith("00"):
        decoded_salt = decoded_salt[:-2]
    return decoded_salt


# Hash prefix per expansion (from validateKey / validateWrathKey / optimizeRenderingCacheLegacy)
HASH_PREFIX = {
    "classic": "b",  # optimizeRenderingCacheLegacy  (TBC)
    "wrath": "w",  # validateWrathKey
    "mists": "",  # validateKey                   (MoP)
}


def generate_key(
    battle_tag: str,
    key_types: list,
    salt: str,
    expiration_days: int = 30,
    expansion: str = "classic",
) -> tuple:
    """
    Generates the final double-encoded key ready to paste into the addon.

    key_types:       list of keyType ints/strings, e.g. [99, 11]
    salt:            >= 8 chars
    expiration_days: 1-34 (hard cap at 34 due to addon's 35-day future check)
    expansion:       "classic" (TBC), "wrath", or "mists" (MoP)
    """
    assert len(salt) >= 8, "Salt must be at least 8 characters"
    assert 1 <= expiration_days <= 34, "expiration_days must be between 1 and 34"
    assert expansion in HASH_PREFIX, f"expansion must be one of {list(HASH_PREFIX)}"

    identifier = get_identifier(battle_tag)
    assert identifier, f"Could not parse BattleTag: {battle_tag!r}"

    prefix = HASH_PREFIX[expansion]
    expiration_ts = int(time.time()) + expiration_days * 24 * 60 * 60

    inner_keys = []
    for kt in key_types:
        # Build raw key with a placeholder hash first to get the length
        placeholder = f"{kt}=00000000={expiration_ts}={salt}"
        eff_salt = effective_salt_for_hash(placeholder, salt)
        hash_value = compute_hash(identifier + prefix + eff_salt)

        raw_key = f"{kt}={hash_value}={expiration_ts}={salt}"
        inner_b64 = base64.b64encode(raw_key.encode()).decode()

        # Keys whose raw length is divisible by 3 produce no '=' padding.
        # Without '=' there is no separator in the combined string, so
        # splitDecodedString merges them with adjacent keys.
        # Adding one '=' is safe: Lua's decodeBase64 strips trailing '=' (line 185).
        if not inner_b64.endswith("="):
            inner_b64 += "="

        inner_keys.append(inner_b64)

    combined = "".join(inner_keys)
    outer_key = base64.b64encode(combined.encode()).decode()

    return outer_key, identifier, hash_value, expiration_ts


if __name__ == "__main__":
    # ------------------------------------------------------------------ config
    BATTLE_TAG = "MXYZPTLK#21477"  # <-- your BattleTag
    KEY_TYPES = [99, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]  # <-- key types (part1 of each inner key)
    SALT = "ab3f9x12"  # <-- >= 8 chars
    EXPIRE_DAYS = 30  # <-- 1-34
    EXPANSION = "classic"  # <-- "classic" (TBC), "wrath", or "mists"
    # --------------------------------------------------------------------------

    if len(sys.argv) == 2:
        BATTLE_TAG = sys.argv[1]

    key, identifier, hash_val, exp_ts = generate_key(BATTLE_TAG, KEY_TYPES, SALT, EXPIRE_DAYS, EXPANSION)

    import datetime

    exp_dt = datetime.datetime.fromtimestamp(exp_ts, datetime.timezone.utc).strftime("%Y-%m-%d %H:%M UTC")

    print(f"\nIdentifier : {identifier}")
    print(f"Expansion  : {EXPANSION}  (prefix='{HASH_PREFIX[EXPANSION]}')")
    print(f"Hash       : {hash_val}")
    print(f"Expires    : {exp_dt}  ({exp_ts})")
    print(f"Key types  : {KEY_TYPES}")
    print(f"\n--- PASTE THIS KEY ---")
    print(key)
    print("----------------------\n")
