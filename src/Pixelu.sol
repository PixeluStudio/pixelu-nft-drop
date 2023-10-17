// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC721} from "solady/src/tokens/ERC721.sol";
import {Ownable} from "solady/src/auth/Ownable.sol";
import {LibString} from "solady/src/utils/LibString.sol";

contract Pixelu is ERC721, Ownable {
    using LibString for uint256;

    // Must end with a forward slash: `/`
    string baseUri;

    constructor(address _owner) {
        _initializeOwner(_owner);
    }

    function name() public pure override returns (string memory) {
        return "Pixelu Studio";
    }

    function symbol() public pure override returns (string memory) {
        return "PIXELU";
    }

    function tokenURI(uint256 id) public view override returns (string memory) {
        return LibString.concat(baseUri, id.toString());
    }

    function setUri(string memory _newUri) external onlyOwner {
        baseUri = _newUri;
    }

    function mint(address to, uint256 id) external onlyOwner {
        _mint(to, id);
    }

    function mintBatch(address[] memory tos, uint256[] memory ids) external onlyOwner {
        require(tos.length == ids.length, "MISMATCH");

        for (uint256 i; i < tos.length; i++) {
            _mint(tos[i], ids[i]);
        }
    }
}
