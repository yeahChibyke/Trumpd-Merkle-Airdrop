// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Trumpd} from "../src/Trumpd.sol";
import {Test, console2} from "forge-std/Test.sol";
import {DeployTrumpd} from "../script/DeployTrumpd.s.sol";

contract TestTrumpd is Test {
    Trumpd nft;
    DeployTrumpd deployer;

    string public constant NFT_NAME = "Trumpd NFT";
    string public constant NFT_SYMBOL = "TRUMPD";

    string public constant TRUMPD_TOKEN_URI =
        "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAxMjggMTI4IiBkYXRhLW5hbWU9IkxheWVyIDEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPjxkZWZzPjxzdHlsZT4uY2xzLTF7ZmlsbDojZjg1NTY1O30uY2xzLTIsLmNscy00LC5jbHMtNntmaWxsOiNmZmZmZmY7fS5jbHMtMntvcGFjaXR5OjAuMjt9LmNscy0ze2ZpbGw6I2YyYmMwZjt9LmNscy00LC5jbHMtOHtvcGFjaXR5OjAuNTt9LmNscy01e2ZpbGw6I2ZiYTg3NTt9LmNscy0xNCwuY2xzLTd7ZmlsbDojMzU2Y2I2O30uY2xzLTE1LC5jbHMtOHtmaWxsOiMzOTNjNTQ7fS5jbHMtMTEsLmNscy0xMiwuY2xzLTE3LC5jbHMtMTgsLmNscy05e2ZpbGw6bm9uZTtzdHJva2UtbGluZWNhcDpyb3VuZDt9LmNscy05e3N0cm9rZTojZmJhODc1O3N0cm9rZS1taXRlcmxpbWl0OjEwO3N0cm9rZS13aWR0aDoyMHB4O30uY2xzLTEwe2ZpbGw6I2ZmYmI5NDt9LmNscy0xMSwuY2xzLTEye3N0cm9rZTojNTE1NTcwO30uY2xzLTExLC5jbHMtMTIsLmNscy0xNywuY2xzLTE4e3N0cm9rZS1saW5lam9pbjpyb3VuZDt9LmNscy0xMSwuY2xzLTEyLC5jbHMtMTh7c3Ryb2tlLXdpZHRoOjJweDt9LmNscy0xMXtvcGFjaXR5OjAuNDt9LmNscy0xMiwuY2xzLTE0e29wYWNpdHk6MC4xO30uY2xzLTEze2ZpbGw6I2ZmODQ3NTt9LmNscy0xNntmaWxsOiNmOGRjMjU7fS5jbHMtMTd7c3Ryb2tlOiNmMmJjMGY7c3Ryb2tlLXdpZHRoOjNweDt9LmNscy0xOHtzdHJva2U6I2ZmODQ3NTt9PC9zdHlsZT48L2RlZnM+PHRpdGxlLz48Y2lyY2xlIGNsYXNzPSJjbHMtMSIgY3g9IjY0IiBjeT0iNjQiIHI9IjYwIi8+PGNpcmNsZSBjbGFzcz0iY2xzLTIiIGN4PSI2NCIgY3k9IjY0IiByPSI0OCIvPjxwYXRoIGNsYXNzPSJjbHMtMyIgZD0iTTM0LDc3LjVWNTAuODZjMC0xNi4zOCwxMi44NC0zMC4yNSwyOS4yMS0zMC42N0EzMC4wNywzMC4wNywwLDAsMSw5NCw1MC4zNFY3Ny41QTUuNSw1LjUsMCwwLDEsODguNSw4M2gtNDlBNS41LDUuNSwwLDAsMSwzNCw3Ny41WiIvPjxwYXRoIGNsYXNzPSJjbHMtNCIgZD0iTTM0LDUwLjQ2VjU4SDk0VjQ5Ljg4aDBBOC44OSw4Ljg5LDAsMCwwLDg1LjExLDQxSDQzYTksOSwwLDAsMC05LDguNzdDMzQsNTAsMzQsNTAuMjMsMzQsNTAuNDZaIi8+PGNpcmNsZSBjbGFzcz0iY2xzLTUiIGN4PSI4OC41IiBjeT0iNjMuNSIgcj0iNy41Ii8+PHBhdGggY2xhc3M9ImNscy02IiBkPSJNNjQsMTI0LjFhNTkuNzgsNTkuNzgsMCwwLDAsNDAtMTUuMjhsLTIuMzktNS42OGMtMS43MS00LTYuMjItNi42NC0xMS4yOS02LjY0SDM3LjY5Yy01LjA3LDAtOS41OCwyLjY2LTExLjI5LDYuNjRMMjQsMTA4LjgyQTU5Ljc4LDU5Ljc4LDAsMCwwLDY0LDEyNC4xWiIvPjxwYXRoIGNsYXNzPSJjbHMtNyIgZD0iTTQ3LDk2LjVIMzcuNjljLTUuMDcsMC05LjU4LDIuNjYtMTEuMjksNi42NEwyNCwxMDguODJhNTkuODQsNTkuODQsMCwwLDAsMzMuMDcsMTQuODdaIi8+PHBvbHlnb24gY2xhc3M9ImNscy04IiBwb2ludHM9IjQ2Ljk4IDk2LjUgNTYuNjggMTIzLjE3IDQwLjg4IDEwOCA0Ni4yNyAxMDUuMzIgMzcuNjkgOTYuNSA0Ni45OCA5Ni41Ii8+PHBhdGggY2xhc3M9ImNscy03IiBkPSJNODEuMTEsOTYuNUg5MC40YzUuMDYsMCw5LjU4LDIuNjYsMTEuMjksNi42NGwyLjM5LDUuNjhBNTkuODQsNTkuODQsMCwwLDEsNzEsMTIzLjY5WiIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtOCIgcG9pbnRzPSI4MS4xMSA5Ni41IDcxLjQxIDEyMy4xNyA4Ny4yIDEwOCA4MS44MiAxMDUuMzIgOTAuNCA5Ni41IDgxLjExIDk2LjUiLz48cGF0aCBjbGFzcz0iY2xzLTYiIGQ9Ik04MS43Miw5OC4yNWEzLjA2LDMuMDYsMCwwLDAtMy4wOC0yLjg4SDQ5LjM2YTMuMDcsMy4wNywwLDAsMC0zLjA4LDIuOTNjMCwuMTEsMCwuMjEsMCwuMzJsMTAuNTIsMTYuNjRMNjQsMTA4LjA1bDcuMTcsNy4xN1M4MS43Myw5OC40OSw4MS43Myw5OUM4MS43Myw5OS4yNiw4MS43Myw5OC40OSw4MS43Miw5OC4yNVoiLz48bGluZSBjbGFzcz0iY2xzLTkiIHgxPSI2NCIgeDI9IjY0IiB5MT0iODYiIHkyPSI5OCIvPjxjaXJjbGUgY2xhc3M9ImNscy0xMCIgY3g9IjYzLjUiIGN5PSI4Ni41IiByPSI5LjUiLz48Y2lyY2xlIGNsYXNzPSJjbHMtNSIgY3g9IjM4LjUiIGN5PSI2My41IiByPSI3LjUiLz48cGF0aCBjbGFzcz0iY2xzLTEwIiBkPSJNMzgsNzMuNjhWNTEuNjFjMC0xMy4yMiw5LjctMjQuNywyMi44Mi0yNi4yNUEyNiwyNiwwLDAsMSw5MCw1MS4xMlY3My42OEExOC4zMiwxOC4zMiwwLDAsMSw3MS42OCw5Mkg1Ni4zMkExOC4zMiwxOC4zMiwwLDAsMSwzOCw3My42OFoiLz48cGF0aCBjbGFzcz0iY2xzLTExIiBkPSJNNjAuMTksODQuMTRhNi40Myw2LjQzLDAsMCwxLDcuMzMsMCIvPjxwYXRoIGNsYXNzPSJjbHMtNSIgZD0iTTY0LDcxaDBhMywzLDAsMCwxLTMtM1Y1MGg2VjY4QTMsMywwLDAsMSw2NCw3MVoiLz48cGF0aCBjbGFzcz0iY2xzLTEyIiBkPSJNNzAuNjUsODYuMzFhNi44Nyw2Ljg3LDAsMCwxLTEzLjc0LDAiLz48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik02MC4xNiwxMjMuODZjMS4yNy4wOCwyLjU1LjE0LDMuODQuMTRzMi41Ny0uMDYsMy44NC0uMTRMNjcsMTE1SDYxWiIvPjxwYXRoIGNsYXNzPSJjbHMtMTMiIGQ9Ik02NC41OCwxMTcuMjJINjMuMjZhNC41OCw0LjU4LDAsMCwxLTQuNTgtNC41OFYxMDhINjkuMTd2NC42NEE0LjU4LDQuNTgsMCwwLDEsNjQuNTgsMTE3LjIyWiIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNiIgcG9pbnRzPSI2NCAxMDggNzQuMTcgOTUuMzggNzguNjQgOTUuMzggNzEuMTcgMTE1LjIyIDY0IDEwOCIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtNiIgcG9pbnRzPSI2NCAxMDggNTMuODMgOTUuMzggNDkuMzYgOTUuMzggNTYuODMgMTE1LjIyIDY0IDEwOCIvPjxwYXRoIGNsYXNzPSJjbHMtMTQiIGQ9Ik04MS43Miw5OC4yNWEzLjA2LDMuMDYsMCwwLDAtMy4wOC0yLjg4SDc0LjE3TDY0LDEwOCw1My44Myw5NS4zN0g0OS4zNmEzLjA2LDMuMDYsMCwwLDAtMy4wOCwyLjkyYzAsLjExLDAsLjIxLDAsLjMybDEwLjUyLDE2LjY0TDY0LDEwOC4wNWw3LjE3LDcuMTdMODEuNzMsOTlDODEuNzMsOTguNzQsODEuNzMsOTguNDksODEuNzIsOTguMjVaIi8+PGNpcmNsZSBjbGFzcz0iY2xzLTYiIGN4PSI1MC41IiBjeT0iNTguNSIgcj0iNS41Ii8+PGNpcmNsZSBjbGFzcz0iY2xzLTE1IiBjeD0iNTEiIGN5PSI1OSIgcj0iMyIvPjxwYXRoIGNsYXNzPSJjbHMtMTYiIGQ9Ik0zMCwyNUg3MC45QTE2Ljg2LDE2Ljg2LDAsMCwxLDg3Ljc3LDQxLjg2aDBBOC4xNCw4LjE0LDAsMCwxLDc5LjYzLDUwSDUzLjc4QTIzLjc4LDIzLjc4LDAsMCwxLDMwLDI2LjIyWiIvPjxwYXRoIGNsYXNzPSJjbHMtMTciIGQ9Ik04MC41LDQ0LjVoLTI2YTE4LjQyLDE4LjQyLDAsMCwxLTUuMjMtLjc1QTE4LjIsMTguMiwwLDAsMSwzNi41LDI2LjE4VjIzLjUiLz48cGF0aCBjbGFzcz0iY2xzLTE3IiBkPSJNNzYuNSwzOC41SDU0LjI2YTEyLjkyLDEyLjkyLDAsMCwxLTguNTYtMy4yMSIvPjxjaXJjbGUgY2xhc3M9ImNscy02IiBjeD0iNzcuNSIgY3k9IjU4LjUiIHI9IjUuNSIvPjxwYXRoIGNsYXNzPSJjbHMtNSIgZD0iTTU2LDU4LjVhNS41LDUuNSwwLDAsMS0xMSwwIi8+PGNpcmNsZSBjbGFzcz0iY2xzLTE1IiBjeD0iNzciIGN5PSI1OSIgcj0iMyIvPjxwYXRoIGNsYXNzPSJjbHMtNSIgZD0iTTgzLDU4LjVhNS41LDUuNSwwLDAsMS0xMSwwIi8+PHBvbHlnb24gY2xhc3M9ImNscy0xNiIgcG9pbnRzPSI4NS44IDUyIDcxLjYzIDUyIDcwLjYzIDU2IDgzLjggNTYgODUuOCA1MiIvPjxwb2x5Z29uIGNsYXNzPSJjbHMtMTYiIHBvaW50cz0iNDIuMjMgNTIgNTYuNCA1MiA1Ny40IDU2IDQ0LjIzIDU2IDQyLjIzIDUyIi8+PHBhdGggY2xhc3M9ImNscy0xMiIgZD0iTTU3LjIzLDY2LjczbC0xLDIuNzFhMy41NCwzLjU0LDAsMCwxLTMuMzIsMi4zM2gwYTMuNTIsMy41MiwwLDAsMC0zLjM4LDIuNWwtMS4wNywzLjUyIi8+PHBhdGggY2xhc3M9ImNscy0xMiIgZD0iTTcwLjQ3LDY2LjczbDEsMi43MWEzLjUyLDMuNTIsMCwwLDAsMy4zMSwyLjMzaDBhMy41MiwzLjUyLDAsMCwxLDMuMzgsMi41bDEuMDcsMy41MiIvPjxsaW5lIGNsYXNzPSJjbHMtMTIiIHgxPSI4NSIgeDI9Ijg3IiB5MT0iNTkiIHkyPSI1OSIvPjxsaW5lIGNsYXNzPSJjbHMtMTIiIHgxPSI4NS4xNyIgeDI9Ijg3LjM3IiB5MT0iNjEuNzUiIHkyPSI2Mi42NiIvPjxsaW5lIGNsYXNzPSJjbHMtMTIiIHgxPSI0MiIgeDI9IjQwIiB5MT0iNTkiIHkyPSI1OSIvPjxsaW5lIGNsYXNzPSJjbHMtMTIiIHgxPSI0Mi40NyIgeDI9IjQwLjI3IiB5MT0iNjEuNzUiIHkyPSI2Mi42NiIvPjxwb2x5bGluZSBjbGFzcz0iY2xzLTE4IiBwb2ludHM9IjcyIDgwLjY4IDcwIDc4IDU4IDc4IDU2IDgwLjY4Ii8+PC9zdmc+";

    address Chibyke = makeAddr("Chibyke");
    address Ifunanya = makeAddr("Ifunanya");

    function setUp() public {
        deployer = new DeployTrumpd();
        nft = deployer.run();
    }

    function testInitializedCorrectly() public view {
        assert(keccak256(abi.encodePacked(nft.name())) == keccak256(abi.encodePacked(NFT_NAME)));
        assert(keccak256(abi.encodePacked(nft.symbol())) == keccak256(abi.encodePacked(NFT_SYMBOL)));
    }

    function testCanViewTokenURI() public {
        nft.mintTrumpd(Ifunanya, 1);

        console2.log(nft.tokenURI(0));
    }

    function testCanMintAndHaveBalance() public {
        nft.mintTrumpd(Chibyke, 1);

        assert(nft.balanceOf(Chibyke) == 1);
    }

    function testCanMintMoreThanOneTrumpd() public {
        nft.mintTrumpd(Chibyke, 5);

        assert(nft.balanceOf(Chibyke) == 5);
    }

    function testCanMintToMultiplePersons() public {
        nft.mintTrumpd(Chibyke, 10);
        nft.mintTrumpd(Ifunanya, 20);

        assert(nft.getTokenCounter() == 30);
        assert(nft.getAmountOfTrumpdOwned(Chibyke) == 10);
        assert(nft.getAmountOfTrumpdOwned(Ifunanya) == 20);
    }
}
