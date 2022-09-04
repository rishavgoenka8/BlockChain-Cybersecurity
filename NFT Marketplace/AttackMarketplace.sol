// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "./NFT.sol";
import "./Marketplace.sol";

contract AttackMarketplace is IERC721Receiver {
    NFT public nft;
    Marketplace public marketplace;

    address NFTAddress;
    address MarketplaceAddress;

    uint public tokenCount;
    uint[] public ownedTokens;

    constructor(address _nftAddress, address _marketplaceAddress) {
        nft = NFT(_nftAddress);
        marketplace = Marketplace(_marketplaceAddress);
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function setAddress(address _nft, address _marketplace) external  {
        NFTAddress = _nft;
        MarketplaceAddress = _marketplace;
    }

    function nftMint(string memory _tokenURI) external {
        tokenCount = nft.mint(_tokenURI);
        ownedTokens.push(tokenCount);
    }

    function setApproval() external {
        nft.setApprovalForAll(MarketplaceAddress, true);
    }

    function addItemToMarketplace(uint listingPrice) external  {
        marketplace.makeItem(nft, tokenCount, listingPrice);
    }

    function purchaseFromMarketplace(uint itemId) external {
        marketplace.purchaseItem(itemId);
    }

    function viewOwnedTokenIDs() public view returns (uint[] memory) {
        return ownedTokens;
    }
}
