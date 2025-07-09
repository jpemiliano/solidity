
// File: interfaceIBancario.sol


pragma solidity ^0.8.19;

interface IBancario {
    function depositar() external payable;

    function consultarSaldo(address usuario) external view returns (uint256);
}

// File: contratoBancario.sol


pragma solidity ^0.8.19;


contract Bancario is IBancario {
    mapping(address => uint256) private saldos;
    event Deposito(address indexed de, uint256 valor);

    function depositar() external payable {
        require(msg.value > 0, "Envie algum Ether");
        saldos[msg.sender] += msg.value;
        emit Deposito(msg.sender, msg.value);
    }

    function consultarSaldo(address usuario) external view returns (uint256) {
        return saldos[usuario];
    }
}

// File: contratoCliente.sol


pragma solidity ^0.8.19;


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
