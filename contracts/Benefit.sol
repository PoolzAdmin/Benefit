// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

import "./IPozBenefit.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract Benefit is IPOZBenefit, Ownable {
    constructor() public {
        MinHold = 1;
    }

    address public TokenAddress;
    address public POZBenefit_Address;
    uint256 public MinHold;

    function SetTokenAddress(address _New_Address) public onlyOwner {
        TokenAddress = _New_Address;
    }

    function SetPOZBenefitAddress(address _New_Address) public onlyOwner {
        POZBenefit_Address = _New_Address;
    }

    function CheckBalance(address _Token, address _Subject)
        internal
        view
        returns (uint256)
    {
        return ERC20(_Token).balanceOf(_Subject);
    }

    function IsPOZHolder(address _Subject) external view returns (bool) {
        return IsPOZInvestor(_Subject);
    }

    function IsPOZInvestor(address _investor) internal view returns (bool) {
        if (TokenAddress == address(0x0) && POZBenefit_Address == address(0x0))
            return false; // Last file in line, no change result
        return ((TokenAddress != address(0x0) &&
            CheckBalance(TokenAddress, _investor) >= MinHold) ||
            (POZBenefit_Address != address(0x0) &&
                IPOZBenefit(POZBenefit_Address).IsPOZHolder(_investor)));
    }
}
