//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import '@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol';

contract DBVNFT is
  ERC721Upgradeable,
  OwnableUpgradeable,
  ERC721BurnableUpgradeable
{
  uint256 public constant ART = 0;
  uint256 public constant PHOTO = 1;
  string internal baseURI;

  using StringsUpgradeable for uint256;

  // Because we are running this through a proxy we cannot use constructor functions. This is becasue we need to init our data in the proxy contract not the ERC721 contract.
  function initialize(
    string memory _name,
    string memory _symbol,
    string memory _baseURI
  ) external initializer {
    // QUESTION: Context is being init twice, once throught the ERC721_init and once through Ownable_init. Is this an issue? Can we bemore efficient?
    __ERC721_init(_name, _symbol);
    __Ownable_init();

    _safeMint(msg.sender, ART, '');
    _safeMint(msg.sender, PHOTO, '');

    baseURI = _baseURI;
  }

  function mint(address to, uint256 id) public onlyOwner {
    _safeMint(to, id, '');
  }

  // Returns e.g. https://dhsgucezdnqh.usemoralis.com/[tokenId].json
  function tokenURI(uint256 _tokenId)
    public
    view
    override
    returns (string memory)
  {
    require(
      _exists(_tokenId),
      'ERC721Metadata: URI query for nonexistent token'
    );
    // Concatenate the components, baseURI and tokenId, to create URI.
    return string(abi.encodePacked(baseURI, _tokenId.toString(), '.json'));
  }

  function contractURI() public view returns (string memory) {
    return baseURI;
  }
}
