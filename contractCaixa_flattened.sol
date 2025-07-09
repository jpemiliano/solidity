
// File: interfaceIPagamento.sol


pragma solidity ^0.8.19;

interface IPagamento {
    function pagar(address to, uint256 valor) external;
    function saldo() external view returns (uint256);
}

// File: contractCaixa.sol


pragma solidity ^0.8.19;
contract Caixa is IPagamento { // or "is IPagamento" — both are valid

    mapping(address => uint256) private creditos;

    function pagar(address to, uint256 valor) external override {
        require(creditos[msg.sender] >= valor, "Saldo insuficiente");
        creditos[msg.sender] -= valor;
        creditos[to] += valor;
    }

    function saldo() external view override returns (uint256) {
        return creditos[msg.sender];
    }

    function depositar() external payable {
        creditos[msg.sender] += msg.value;
    }
}
