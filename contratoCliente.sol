// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./contratoBancario.sol"; // ou declare inline acima

contract Cliente {
    address public contratoBanco;

    constructor(address _banco) {
        contratoBanco = _banco;
    }

    /// @notice Envia Ether ao banco usando a interface
    function enviarDeposito() external payable {
        require(msg.value > 0, "Precisa enviar algum Ether");
        IBancario(contratoBanco).depositar{value: msg.value}();
    }

    /// @notice Consulta o saldo do Cliente no contrato Bancario
    function verMeuSaldo() external view returns (uint256) {
        return IBancario(contratoBanco).consultarSaldo(address(this));
    }

    /// @notice Consulta o saldo de outro endereço (opcional)
    function verSaldoDe(address usuario) external view returns (uint256) {
        return IBancario(contratoBanco).consultarSaldo(usuario);
    }
}
