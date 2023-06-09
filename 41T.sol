// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.0/utils/Counters.sol";

contract For1Room is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    mapping(uint256 => string) private tokenNames;
    mapping(uint256 => string) private tokenDescriptions;
    mapping(address => mapping(uint256 => uint256)) private _ownedTokens;

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("For1Room", "41T") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://api-41room.islab.dev/";
    }


    function safeMint(address to, string memory uri,string memory name, string memory description) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        _setTokenName(tokenId, name);
        _setTokenDescription(tokenId, description);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

        function _setTokenName(uint256 tokenId, string memory name) internal {
        tokenNames[tokenId] = name;
    }

    function _setTokenDescription(uint256 tokenId, string memory description) internal {
        tokenDescriptions[tokenId] = description;
    }

    function getTokenInfo(uint256 tokenId) public view  returns (string memory name, string memory description, string memory uri) {
        require(_exists(tokenId), "Token does not exist");

        name = tokenNames[tokenId];
        description = tokenDescriptions[tokenId];
        uri = tokenURI(tokenId);
    }
    function getTotalMintCount() public view returns (uint256) {
        return _tokenIdCounter.current();
    }
}
