// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract CofrinhoSeguro is ReentrancyGuard {
    mapping(address => uint256) public saldos;

    // Qualquer um pode depositar
    function depositar() external payable {
        require(msg.value > 0, "Valor deve ser maior que zero.");
        saldos[msg.sender] += msg.value;
    }

    // Retirar todo o saldo com protecao contra reentrancia
    function sacar() external nonReentrant  {
        uint256 valor = saldos[msg.sender];
         // Check-Effect-Interaction pattern
        require(valor > 0, "Sem saldo para sacar.");//CHECK       
        saldos[msg.sender] = 0; // EFFECT: altera o estado antes da transferência
        bool sucesso = payable(msg.sender).send(valor);//INTERACTION: interage com o contrato
        require(sucesso, "Falha no envio");
    }

    // Apenas para visualização
    function saldoAtual() external view returns (uint256) {
        return saldos[msg.sender];
    }
}
