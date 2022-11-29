-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Stream = TSM.Init("Util.ReactiveClasses.Stream") ---@class Util.ReactiveClasses.Stream
local Publisher = TSM.Include("Util.ReactiveClasses.Publisher")
local Table = TSM.Include("Util.Table")
local ReactiveStream = TSM.Include("LibTSMClass").DefineClass("ReactiveStream") ---@class ReactiveStream




-- ============================================================================
-- Module Functions
-- ============================================================================

---Creates a new stream object.
---@return ReactiveStream @The stream
function Stream.Create()
	return ReactiveStream()
end



-- ============================================================================
-- ReactiveStream - Class Meta Methods
-- ============================================================================

function ReactiveStream:__init()
	self._publishers = {}
	self._scripts = {}
end



-- ============================================================================
-- ReactiveStream - Public Class Methods
-- ============================================================================

---Creates a new publisher for the stream.
---@return ReactivePublisher @The publisher object
function ReactiveStream:Publisher()
	local publisher = Publisher.Get()
	publisher:_Acquire(self)
	tinsert(self._publishers, publisher)
	return publisher
end

---Sends a new data value the stream's publishers.
---@param data table The data to send
function ReactiveStream:Send(data)
	for _, publisher in pairs(self._publishers) do
		publisher:_HandleData(data)
	end
end

---Registers a script handler on the stream.
---@param script '"OnPublisherCommit"'|'"OnPublisherCancelled"' The script
---@param handler? fun(stream: ReactiveStream, publisher: ReactivePublisher) The script handler or nil to remove an existing handler
function ReactiveStream:SetScript(script, handler)
	assert(handler == nil or type(handler) == "function")
	assert(script == "OnPublisherCommit" or script == "OnPublisherCancelled")
	if handler then
		assert(type(handler) == "function")
		assert(not self._scripts[script])
		self._scripts[script] = handler
	else
		assert(self._scripts[script])
		self._scripts[script] = nil
	end
end

---Gets the number of active publishers on the stream.
---@return number
function ReactiveStream:GetNumPublishers()
	return #self._publishers
end



-- ============================================================================
-- ReactiveStream - Private Class Methods
-- ============================================================================

function ReactiveStream:_HandlePublisherEvent(publisher, event)
	if event == "OnHandled" then
		-- do nothing - we don't support auto-storing
	elseif event == "OnCommit" then
		if self._scripts.OnPublisherCommit then
			self._scripts.OnPublisherCommit(self, publisher)
		end
	elseif event == "OnCancel" then
		assert(Table.RemoveByValue(self._publishers, publisher) == 1)
		if self._scripts.OnPublisherCancelled then
			self._scripts.OnPublisherCancelled(self, publisher)
		end
	else
		error("Unknown event: "..tostring(event))
	end
end
