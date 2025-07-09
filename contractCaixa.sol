// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./interfaceIPagamento.sol";
contract Caixa is IPagamento { 

    mapping(address => uint256) private creditos;

    function pagar(address to, uint256 valor) external  {
        require(creditos[msg.sender] >= valor, "Saldo insuficiente");
        creditos[msg.sender] -= valor;
        creditos[to] += valor;
    }

    function saldo() external view  returns (uint256) {
        return creditos[msg.sender];
    }

    function depositar() external payable {
        creditos[msg.sender] += msg.value;
    }
}
