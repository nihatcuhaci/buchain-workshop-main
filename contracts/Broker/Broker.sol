// SPDX-License-Identifier: MIT
// Prepared for BUchain Workshop by Murat Ögat

pragma solidity ^0.8.0;

import "./IBroker.sol";
import "../Utils/Ownable.sol";
import "../ERC20/IERC20.sol";

contract Broker is IBroker, Ownable {

    IERC20 public immutable currency;
    IERC20 public immutable shares;
    uint256 private price;
    apping (address => uint256) private Paid;
    mapping (address=>uint256) private Deposit;
    mapping (address=>uint256) private SharesCount;

    constructor(IERC20 _shares, uint256 _price, IERC20 _currency, address _owner) Ownable(_owner) {
        shares = _shares;
        price = _price;
        currency = _currency;
    }
    
    function getShares() external view returns (IERC20) { 

    }

    function getBaseCurrency() external view returns (IERC20) {

    }

    function getPriceInBaseCurrency() external view returns (uint256) {

    }

    function setPriceInBaseCurrency(uint256 _price) external onlyOwner {
        price = _price


    }

    function getPriceInETH(uint256 _amountShares) external returns (uint256) {

    }

    function getPriceInToken(uint256 _amountShares, bytes memory path) external returns (uint256) {

    }

    function buyWithBaseCurrency(uint256 _amountShares) external {
        uint256 amountCurrency;
        amountCurrency = _amountShares * price;

        currency.transferFrom(msg.sender, address(this), amountCurrency);
        Paid[msg.sender] += amountCurrency;
        Deposit[msg.sender] += amountCurrency;
 
        require(Paid[msg.sender] == amountCurrency, "error1");
        shares.transfer(msg.sender, _amountShares);
        Paid[msg.sender] -= amountCurrency;
        SharesCount[msg.sender] += _amountShares;

    }

    function buyWithETH(uint256 _amountShares) external {

    }

    function buyWithToken(uint256 _amountShares, address _tokenAddress) external {
        IERC20 token = IERC20(_tokenAddress);

        uint24 poolFee = 2000;
        bytes memory path = abi.encodePacked(_tokenAddress, poolFee, DAI);
        address recipient = msg.sender;
        uint256 deadline = block.timestamp;
        uint256 amountOut = _amountShares * price;
        uint256 amountInMaximum = _amountShares * price;

    }

    function sellForBaseCurrency(uint256 _amountShares) external {
        uint256 daiAmount = price * _amountShares;
        shares.transferFrom(msg.sender, address(this), _amountShares);
        currency.transfer(msg.sender, daiAmount);
        userToSharesCount[msg.sender] -= _amountShares;

    }

    function sellForWETH(uint256 _amountShares) external {

    }

    function withdrawShares(uint256 _amountShares, address _recipient) external onlyOwner {
         shares.transfer(_recipient, _amountShares);


    }
    
    function withdrawETH(address _recipient) external onlyOwner {
         (uint sent, bytes memory data) = _recipient.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

    }

    function withdrawToken(address _token, address _recipient) external onlyOwner {
        IERC20 token = IERC20(_token);
        uint256 balance = token.balanceOf(address(this));
        token.transfer(_recipient, balance);


    }
}