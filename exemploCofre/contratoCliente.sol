// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./interfaceICofre.sol"; // ou declare inline se preferir

contract Cliente {
    address public cofreEndereco;

    event Interacao(string acao, address usuario, uint256 valor);

    constructor(address _cofre) {
        cofreEndereco = _cofre;
    }

    /// @notice Deposita Ether no Cofre usando interface
    function enviarDeposito() external payable {
        require(msg.value > 0, "Precisa enviar algum Ether");
        ICofre(cofreEndereco).depositar{value: msg.value}();
        emit Interacao("deposito", msg.sender, msg.value);
    }

    /// @notice Consulta saldo pessoal no Cofre
    function verMeuSaldo() external view returns (uint256) {
        return ICofre(cofreEndereco).consultarSaldo(address(this));
    }

    /// @notice Solicita saque do Cofre
    function requisitarSaque(uint256 valor) external payable {
        ICofre(cofreEndereco).sacar(valor);
        emit Interacao("saque", address(this), valor);
    }
}
