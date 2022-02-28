pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract SmartContract is ERC721,ERC721Enumerable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct NFTTokenIds {
        string[] tokenIds;
    }

    mapping(address=>NFTTokenIds) ownerNFTs;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("Smart Contract","SC"){}

    function mint(address minterAddress,string memory _tokenURI) public payable returns(uint256) {
        require(msg.value >= 0.001 ether);
        _tokenIds.increment();
        uint256 _newItemId = _tokenIds.current();
        _mint(minterAddress,_newItemId);
        _setTokenURI(_newItemId,_tokenURI);
        addNFTstoOwner(_newItemId,minterAddress);
        return _newItemId;
    }

    function addNFTstoOwner(uint256 _tokenId,address _minterAddress) private {
        ownerNFTs[_minterAddress].tokenIds.push(_tokenURIs[_tokenId]);
    }

    function getOwnerNFTs(address _minterAddress) public view returns(address,string[] memory) {
        return(_minterAddress,ownerNFTs[_minterAddress].tokenIds);
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }


    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return _tokenURIs[_tokenId];
    }

}