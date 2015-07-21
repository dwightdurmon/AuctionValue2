AuctionValue2 = CreateFrame("Frame")
local AV = AuctionValue2

AV:SetScript("OnEvent", function(self, event, addon)
	if event == "ADDON_LOADED" and addon == "Blizzard_AuctionUI" then	
		self.t = AuctionFrameAuctions:CreateFontString()
		self.t:SetFontObject(GameFontNormal)
		self.t:SetPoint("TOPLEFT", AuctionFrameAuctions, "TOPLEFT", 450, -17)
		self.t2 = AuctionFrameAuctions:CreateFontString()
		self.t2:SetFontObject(GameFontNormal)
		self.t2:SetPoint("TOPLEFT", AuctionFrameAuctions, "TOPLEFT", 620, -17)
		self:UnregisterEvent("ADDON_LOADED")
		self:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
		
	elseif event == "AUCTION_OWNED_LIST_UPDATE" then
		local total = 0
		local incoming = 0
		for i=1, GetNumAuctionItems("owner") do
			local buyout, _, _, _, _, _, sold = select(10, GetAuctionItemInfo("owner", i))
			total = total + buyout
			if sold == 1 then
				incoming = incoming + buyout
			end
		end		
		AuctionValueTotal2 = total
		self.t:SetText(format("Buyout: |cffffffff%s|r", GetCoinTextureString(total)))
		self.t2:SetText(incoming > 0 and format("Incoming: |cffffffff%s|r", GetCoinTextureString(incoming)) or "")
	end
end)

AV:RegisterEvent("ADDON_LOADED")

function AV:Slash()
	local name = "|cff8888ffAuctionValue2:|r "
	if AuctionValueTotal2 then
		print(AuctionValueTotal2 ~= 0 and (name .. "Last total value of auctions: " .. GetCoinTextureString(AuctionValueTotal2)) or (name .. "You have no known auctions."))
	else
		print(name .. "Please visit the auction house first.")
	end
end

SLASH_AUCTIONVALUE1 = "/auctionvalue2"
SLASH_AUCTIONVALUE2 = "/av2"
SlashCmdList["AUCTIONVALUE"] = AV.Slash