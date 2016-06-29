function A = structured_rp(ImHeight,ImWidth,MaxHeight,MaxWidth,d)
% STRUCTURED_RP   Random projections with nonzero entries corresponding to
% contiguous rectangular tiles of pixels
%
%   A = STRUCTURED_RP returns an ImHeight*ImWidth x d random matrix with
%   nonzero entries in each column restricted to a contiguous tile of
%   pixels

p = ImHeight*ImWidth;
A = zeros(p,d);

if isempty(MaxHeight)
    MaxHeight = ImHeight;
end

if isempty(MaxWidth)
    MaxWidth = ImWidth;
end

for i = 1:d
    % sample random height and width of the tile
    TileHeight = randi(MaxHeight);
    TileWidth = randi(MaxWidth);
    
    % sample random coordinates for the top-left of the tile
    PossibleIdx = repmat((1:ImHeight-TileHeight+1)',1,ImWidth-TileWidth+1) + repmat(0:ImHeight:ImHeight*(ImWidth-TileWidth),ImHeight-TileHeight+1,1);
    Element = randi(numel(PossibleIdx));
    TopLeftIdx = PossibleIdx(Element);
    
    %Sample -1 or +1 for each nonzero coordinate
    NzIdx = repmat((TopLeftIdx:TopLeftIdx+TileHeight-1)',1,TileWidth) + repmat(0:ImHeight:ImHeight*(TileWidth-1),TileHeight,1);
    A(NzIdx(:),i) = round(rand(numel(NzIdx),1))*2-1;
end

A = sparse(A);