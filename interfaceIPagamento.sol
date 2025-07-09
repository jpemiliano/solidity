// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IPagamento {    
    function pagar(address to, uint256 valor) external;
    function saldo() external view returns (uint256);   
}
