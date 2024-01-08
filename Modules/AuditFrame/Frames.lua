local WealthAudit = select(2, ...)
WealthAudit.AUDIT_FRAME.FRAMES = {}

function WealthAudit.AUDIT_FRAME.FRAMES:Init()
    local sizeX = 320
    local sizeY = 140
    local offsetX = -10
    local offsetY = 30

    --- @type GGUI.Frame | GGUI.Widget
    local frame = WealthAudit.GGUI.Frame({
        parent=UIParent, 
        anchorParent=UIParent,
        anchorA="CENTER",anchorB="CENTER",
        sizeX=sizeX,sizeY=sizeY,
        offsetX=offsetX,offsetY=offsetY,
        frameID=WealthAudit.CONST.FRAMES.AUDIT_FRAME, 
        title="WealthAudit",
        closeable=true,
        moveable=true,
        backdropOptions=WealthAudit.CONST.DEFAULT_BACKDROP_OPTIONS, 
        frameConfigTable=WealthAuditGGUIConfig,
        frameTable=WealthAudit.MAIN.FRAMES,
    })

    local function createContent(frame)

        frame:Hide()
    end

    createContent(frame)
end