// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JogoDaVelha {
    uint32 public count = 0;
    Game[] public games;

    event GameHasCreated(uint32 count, address owner, string game_name);
    event EnterOtherPlayer(uint32 game_id, address oponent, string game_name);
    event TurnPlayer(uint32 game_id, address _address, uint32 turn);

    struct Game {
        uint32 id;
        address owner;
        string name;
        address oponent;
        address winner;
        uint32[] turns_owner;
        uint32[] turns_oponent;
        address next_movement;
    }

    function openGames() public view returns (Game[] memory) {
        uint256 j = 0;
        uint256 resultCount = 0;

        for (uint256 index = 0; index < games.length; index++) {
            if (games[index].oponent == address(0)) {
                resultCount++;
            }
        }

        Game[] memory result = new Game[](resultCount);

        for (uint256 index = 0; index < games.length; index++) {
            if (games[index].oponent == address(0)) {
                result[j] = games[index];
                j++;
            }
        }
        return result;
    }

    function runTurn(uint32 game_id, uint32 movement) public {
        require(games[game_id - 1].winner == address(0), "JOGO ENCERRADO!");
        require(
            games[game_id - 1].next_movement == msg.sender,
            "NAO E SUA JOGADA"
        );
        require(
            validate_turn(games[game_id - 1].turns_owner, movement),
            "POSICAO OCUPADA"
        );
        require(
            validate_turn(games[game_id - 1].turns_oponent, movement),
            "POSICAO OCUPADA"
        );
        // require(
        //     (games[game_id - 1].turns_oponent.length +
        //         games[game_id - 1].turns_owner.length) == 9,
        //     "EMPATE"
        // );
        if (games[game_id - 1].owner == msg.sender) {
            games[game_id - 1].turns_owner.push(movement);
            bool win = validade_win(games[game_id - 1].turns_owner);
            if (win) games[game_id - 1].winner = games[game_id - 1].oponent;
            games[game_id - 1].next_movement = games[game_id - 1].oponent;
        } else if (games[game_id - 1].oponent == msg.sender) {
            games[game_id - 1].turns_oponent.push(movement);
            bool win = validade_win(games[game_id - 1].turns_oponent);
            if (win) games[game_id - 1].winner = games[game_id - 1].owner;
            games[game_id - 1].next_movement = games[game_id - 1].owner;
        }
        emit TurnPlayer(game_id, msg.sender, movement);
    }

    function enterGame(uint32 game_id) public {
        require(count > 0, "GAME INVALIDO");
        require(games[game_id - 1].oponent == address(0), "GAME INVALIDO");
        games[game_id - 1].oponent = msg.sender;
        games[game_id - 1].next_movement = random(game_id);
        emit EnterOtherPlayer(game_id, msg.sender, games[game_id - 1].name);
    }

    function createGame(string memory _name) public returns (uint32) {
        count = count + 1;
        uint32[] memory empty;
        Game memory game = Game(
            count,
            msg.sender,
            _name,
            address(0),
            address(0),
            empty,
            empty,
            address(0)
        );
        games.push(game);
        emit GameHasCreated(count, msg.sender, _name);
        return count;
    }

    function random(uint32 game_id) private view returns (address) {
        address[] memory players = new address[](2);
        players[0] = games[game_id - 1].owner;
        players[1] = games[game_id - 1].oponent;

        uint256 index = uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, players))
        ) % players.length;
        return players[index];
    }

    function validade_win(uint32[] memory turns) private pure returns (bool) {
        bool v0 = false;
        bool v1 = false;
        bool v2 = false;
        bool v3 = false;
        bool v4 = false;
        bool v5 = false;
        bool v6 = false;
        bool v7 = false;
        bool v8 = false;

        for (uint32 index = 0; index < turns.length; index++) {
            if (!v0) v0 = turns[index] == 0;
            if (!v1) v1 = turns[index] == 1;
            if (!v2) v2 = turns[index] == 2;
            if (!v3) v3 = turns[index] == 3;
            if (!v4) v4 = turns[index] == 4;
            if (!v5) v5 = turns[index] == 5;
            if (!v6) v6 = turns[index] == 6;
            if (!v7) v7 = turns[index] == 7;
            if (!v8) v8 = turns[index] == 8;
        }
        if (v0 && v1 && v2) return true;
        if (v3 && v4 && v5) return true;
        if (v6 && v7 && v8) return true;
        if (v0 && v3 && v6) return true;
        if (v1 && v4 && v7) return true;
        if (v2 && v5 && v8) return true;
        if (v0 && v4 && v8) return true;
        if (v2 && v4 && v6) return true;
        return false;
    }

    function validate_turn(uint32[] memory array, uint32 movement)
        private
        pure
        returns (bool)
    {
        for (uint32 index = 0; index < array.length; index++) {
            if (movement == array[index]) {
                revert("POSICAO JA OCUPADA");
            }
        }
        return true;
    }
}
