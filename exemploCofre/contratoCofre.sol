// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "./interfaceICofre.sol";
contract Cofre is ICofre {
    mapping(address => uint256) public creditos;

    event Deposito(address indexed de, uint256 valor);
    event Saque(address indexed para, uint256 valor);

    /// @notice Permite depósito de Ether
    function depositar() external payable {
        require(msg.value > 0, "Envie algum Ether");
        creditos[msg.sender] += msg.value;
        emit Deposito(msg.sender, msg.value);
    }

    /// @notice Consulta saldo do endereço especificado
    function consultarSaldo(address usuario) external view returns (uint256) {
        return creditos[usuario];
    }

    /// @notice Permite saque do saldo acumulado
    function sacar(uint256 valor) external {
        require(creditos[msg.sender] >= valor, "Saldo insuficiente");
        creditos[msg.sender] -= valor;
        payable(msg.sender).transfer(valor);
        emit Saque(msg.sender, valor);
    }
}
