// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IBancario {
    function depositar() external payable;

    function consultarSaldo(address usuario) external view returns (uint256);
}
