-- Main Component Module
-- Username
-- November 2, 2022



local MainComponentModule = {}

function MainComponentModule:Create(parent)
    local partsWithId = {}
    local awaitRef = {}
    
    local root = {
        ID = 0;
        Type = "ScreenGui";
        Properties = {
            Name = "MainGui";
        };
        Children = {
            {
                ID = 1;
                Type = "Frame";
                Properties = {
                    Name = "ScoreFrame";
                    Position = UDim2.new(0.5,-188,0,3);
                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0,376,0,100);
                    BackgroundColor3 = Color3.new(1,1,1);
                };
                Children = {
                    {
                        ID = 2;
                        Type = "TextLabel";
                        Properties = {
                            FontSize = Enum.FontSize.Size48;
                            TextColor3 = Color3.new(1,0,0);
                            BorderColor3 = Color3.new(1,0,0);
                            Text = "0";
                            BackgroundTransparency = 0.5;
                            Font = Enum.Font.SourceSansBold;
                            Name = "Bright red";
                            Position = UDim2.new(0,5,0,5);
                            Size = UDim2.new(0,100,0,50);
                            TextSize = 48;
                            BorderSizePixel = 5;
                            BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                        };
                        Children = {
                            {
                                ID = 3;
                                Type = "TextLabel";
                                Properties = {
                                    BackgroundTransparency = 0.5;
                                    FontSize = Enum.FontSize.Size18;
                                    Size = UDim2.new(1,0,0,0);
                                    ClipsDescendants = true;
                                    BorderColor3 = Color3.new(0,0,1);
                                    Text = "Flag Returned!";
                                    TextColor3 = Color3.new(1,1,1);
                                    TextStrokeTransparency = 0;
                                    TextWrapped = true;
                                    Font = Enum.Font.SourceSansBold;
                                    Name = "Notification";
                                    Position = UDim2.new(0,0,1,5);
                                    TextSize = 18;
                                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                                    BorderSizePixel = 0;
                                    TextWrap = true;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 4;
                        Type = "TextLabel";
                        Properties = {
                            FontSize = Enum.FontSize.Size48;
                            TextColor3 = Color3.new(0,0,1);
                            BorderColor3 = Color3.new(0,0,1);
                            Text = "0";
                            BackgroundTransparency = 0.5;
                            Font = Enum.Font.SourceSansBold;
                            Name = "Bright blue";
                            Position = UDim2.new(1,-105,0,5);
                            Size = UDim2.new(0,100,0,50);
                            TextSize = 48;
                            BorderSizePixel = 5;
                            BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                        };
                        Children = {
                            {
                                ID = 5;
                                Type = "TextLabel";
                                Properties = {
                                    BackgroundTransparency = 0.5;
                                    FontSize = Enum.FontSize.Size18;
                                    Size = UDim2.new(1,0,0,0);
                                    ClipsDescendants = true;
                                    BorderColor3 = Color3.new(0,0,1);
                                    Text = "Flag Returned!";
                                    TextColor3 = Color3.new(1,1,1);
                                    TextStrokeTransparency = 0;
                                    TextWrapped = true;
                                    Font = Enum.Font.SourceSansBold;
                                    Name = "Notification";
                                    Position = UDim2.new(0,0,1,5);
                                    TextSize = 18;
                                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                                    BorderSizePixel = 0;
                                    TextWrap = true;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 6;
                        Type = "TextLabel";
                        Properties = {
                            BackgroundTransparency = 0.5;
                            FontSize = Enum.FontSize.Size48;
                            Size = UDim2.new(0,150,0,75);
                            TextColor3 = Color3.new(81/85,81/85,81/85);
                            TextStrokeColor3 = Color3.new(2/15,2/15,2/15);
                            Text = "00:00";
                            BorderColor3 = Color3.new(0,0,1);
                            TextStrokeTransparency = 0;
                            TextWrapped = true;
                            Font = Enum.Font.SourceSansBold;
                            Name = "Timer";
                            Position = UDim2.new(0.5,-75,0,0);
                            TextSize = 48;
                            BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                            BorderSizePixel = 0;
                            TextWrap = true;
                        };
                        Children = {
                            {
                                ID = 7;
                                Type = "TextLabel";
                                Properties = {
                                    Visible = false;
                                    FontSize = Enum.FontSize.Size14;
                                    TextColor3 = Color3.new(1,1,1);
                                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                                    Text = "INTERMISSION";
                                    TextStrokeTransparency = 0;
                                    Font = Enum.Font.SourceSans;
                                    Name = "Intermission";
                                    BackgroundTransparency = 1;
                                    Size = UDim2.new(1,0,0,20);
                                    TextSize = 14;
                                    BackgroundColor3 = Color3.new(1,1,1);
                                };
                                Children = {};
                            };
                            {
                                ID = 8;
                                Type = "TextLabel";
                                Properties = {
                                    Visible = false;
                                    FontSize = Enum.FontSize.Size14;
                                    TextColor3 = Color3.new(1,1,1);
                                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                                    Text = "WAITING FOR  PLAYERS";
                                    TextStrokeTransparency = 0;
                                    Font = Enum.Font.SourceSans;
                                    Name = "WaitingForPlayers";
                                    Position = UDim2.new(0,0,1,-20);
                                    BackgroundTransparency = 1;
                                    Size = UDim2.new(1,0,0,20);
                                    TextSize = 14;
                                    BackgroundColor3 = Color3.new(1,1,1);
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 9;
                Type = "Frame";
                Properties = {
                    Visible = false;
                    Name = "VictoryMessage";
                    Position = UDim2.new(0.5,-50,0.5,-25);
                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                    BackgroundTransparency = 1;
                    Size = UDim2.new(0,200,0,50);
                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                };
                Children = {
                    {
                        ID = 10;
                        Type = "TextLabel";
                        Properties = {
                            Visible = false;
                            FontSize = Enum.FontSize.Size48;
                            TextColor3 = Color3.new(1,1,1);
                            BorderColor3 = Color3.new(9/85,14/85,53/255);
                            Text = "Tie!";
                            TextStrokeTransparency = 0;
                            BackgroundTransparency = 0.5;
                            Font = Enum.Font.SourceSansBold;
                            Name = "Tie";
                            Position = UDim2.new(0,-75,0,0);
                            Size = UDim2.new(1,75,0,50);
                            TextSize = 48;
                            BorderSizePixel = 0;
                            BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                        };
                        Children = {};
                    };
                    {
                        ID = 11;
                        Type = "Frame";
                        Properties = {
                            Visible = false;
                            Name = "Win";
                            BackgroundTransparency = 1;
                            BorderColor3 = Color3.new(9/85,14/85,53/255);
                            Size = UDim2.new(1,0,1,0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = Color3.new(1,1,1);
                        };
                        Children = {
                            {
                                ID = 12;
                                Type = "TextLabel";
                                Properties = {
                                    Visible = false;
                                    FontSize = Enum.FontSize.Size48;
                                    TextColor3 = Color3.new(0,1/3,1);
                                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                                    Text = "Blue";
                                    TextXAlignment = Enum.TextXAlignment.Right;
                                    TextStrokeTransparency = 0;
                                    BackgroundTransparency = 0.5;
                                    Font = Enum.Font.SourceSansBold;
                                    Name = "Blue";
                                    Position = UDim2.new(0,-80,0,0);
                                    Size = UDim2.new(0,80,0,50);
                                    TextSize = 48;
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                                };
                                Children = {};
                            };
                            {
                                ID = 13;
                                Type = "TextLabel";
                                Properties = {
                                    Visible = false;
                                    FontSize = Enum.FontSize.Size48;
                                    TextColor3 = Color3.new(1,0,0);
                                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                                    Text = "Red";
                                    TextXAlignment = Enum.TextXAlignment.Right;
                                    TextStrokeTransparency = 0;
                                    BackgroundTransparency = 0.5;
                                    Font = Enum.Font.SourceSansBold;
                                    Name = "Red";
                                    Position = UDim2.new(0,-75,0,0);
                                    Size = UDim2.new(0,75,0,50);
                                    TextSize = 48;
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                                };
                                Children = {};
                            };
                            {
                                ID = 14;
                                Type = "TextLabel";
                                Properties = {
                                    FontSize = Enum.FontSize.Size48;
                                    TextColor3 = Color3.new(1,1,1);
                                    BorderColor3 = Color3.new(9/85,14/85,53/255);
                                    Text = "team wins!";
                                    TextStrokeTransparency = 0;
                                    Font = Enum.Font.SourceSansBold;
                                    BackgroundTransparency = 0.5;
                                    TextXAlignment = Enum.TextXAlignment.Left;
                                    TextSize = 48;
                                    Size = UDim2.new(1,0,0,50);
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = Color3.new(31/255,31/255,31/255);
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
        };
    };
    
    local function Scan(item, parent)
        local obj = Instance.new(item.Type)
        if (item.ID) then
            local awaiting = awaitRef[item.ID]
            if (awaiting) then
                awaiting[1][awaiting[2]] = obj
                awaitRef[item.ID] = nil
            else
                partsWithId[item.ID] = obj
            end
        end
        for p,v in pairs(item.Properties) do
            if (type(v) == "string") then
                local id = tonumber(v:match("^_R:(%w+)_$"))
                if (id) then
                    if (partsWithId[id]) then
                        v = partsWithId[id]
                    else
                        awaitRef[id] = {obj, p}
                        v = nil
                    end
                end
            end
            obj[p] = v
        end
        for _,c in pairs(item.Children) do
            Scan(c, obj)
        end
        obj.Parent = parent
        return obj
    end
    
    Scan(root, parent) 




end


return MainComponentModule