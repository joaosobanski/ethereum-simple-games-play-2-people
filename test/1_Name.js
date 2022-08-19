var Name = artifacts.require("Name");

contract('Name', function (accounts) {

    describe('testando var name', () => {
        it("verifica se nome é Filip", async () => {
            const instance = await Name.deployed();

            const name = await instance.getName.call();

            assert.equal(name, "Filip", 'nome n e Felip');

        });
        it("troca nome para Jonny", async () => {
            const instance = await Name.deployed();

            await instance.setName('Jonny');

        });
        it("verifica se nome é Jonny", async () => {
            const instance = await Name.deployed();

            const name2 = await instance.getName.call();

            assert.equal(name2, "Jonny", 'me n e Jonny');
        });
    });

}); 