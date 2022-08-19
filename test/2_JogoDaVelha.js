var JogoDaVelha = artifacts.require("JogoDaVelha");
var Name = artifacts.require("Name");

contract('JogoDaVelha', function (accounts) {
    describe('testando criacao de game', () => {

        // it("verifica se nome é Filip", async () => {
        //     const instance = await Name.deployed();

        //     const name2 = await instance.getName.call();

        //     assert.equal(name2, "Kratuz", 'me n e Filip');
        // });
        // it("verifica game count é zero", async () => {
        //     const instance = await JogoDaVelha.deployed();

        //     const count = await instance.count.call();
        //     //   console.log(count)
        //     assert.equal(count, 0, `count ${count}`);
        // });

        it("cria game 1 primeiro game", async () => {
            const instance = await JogoDaVelha.deployed();

            await instance.createGame('primeiro game');
        });

        it("entrar no game", async () => {
            const instance = await JogoDaVelha.deployed();
            await instance.enterGame(1, { from: accounts[2] });
        });

        it("validar se tem oponent", async () => {
            const instance = await JogoDaVelha.deployed();

            const game = await instance.games(0);
            assert.equal(game.oponent, accounts[2], `conta diferente ${game.oponent}`);
        });

        it("dar lance 1", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 0, { from: next_.next_movement });
        });
        it("dar lance 2", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 3, { from: next_.next_movement });
        });
        it("dar lance 3", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 1, { from: next_.next_movement });
        });
        it("dar lance 4", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 4, { from: next_.next_movement });
        });
        it("dar lance 5", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 2, { from: next_.next_movement });
        });
        it("dar lance 6", async () => {
            const instance = await JogoDaVelha.deployed();

            const next_ = await instance.games(0);

            await instance.runTurn(1, 5, { from: next_.next_movement });
        });

        it("validar se tem oponent", async () => {
            const instance = await JogoDaVelha.deployed();

            const game = await instance.games(0);
            assert.equal(game.oponent, accounts[2], `conta diferente ${game.oponent}`);
        });

        it("vencedor", async () => {
            const instance = await JogoDaVelha.deployed();

            const game = await instance.games(0);
            console.log("vencedor: ", game.winner)
        });

        // it("verificar se o nome do game 1 é primeiro game", async () => {
        //     const instance = await JogoDaVelha.deployed();

        //     const game = await instance.games(0);
        //     const compare = 'primeiro game';
        //     assert.equal(game.name, compare, `nome do game não é ${compare}`);
        // });

        // it("verificar se o nome do game 1 é segundo game", async () => {
        //     const instance = await JogoDaVelha.deployed();
        //     const game = await instance.games(0);
        //     const compare = 'segundo game';
        //     assert.equal(game.name, compare, `nome do game não é ${compare}`);
        // });

        // it("buscar games abertos", async () => {
        //     const instance = await JogoDaVelha.deployed();

        //     const games = await instance.openGames();
        //     console.log(games)
        //     // const compare = 'primeiro game';
        //     // assert.equal(game.name, compare, `nome do game não é ${compare}`);
        // });

    });



});

