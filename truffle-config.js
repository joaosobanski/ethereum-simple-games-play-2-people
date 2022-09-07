module.exports = {
  migrations_directory: "./migrations",
  networks: {
    loc_development_development: {
      network_id: "5777",
      port: 8544,
      host: "127.0.0.1"
    },
    development: {
      network_id: "5777",
      port: 8544,
      host: "127.0.0.1"
    },
  },
  compilers: {
    solc: {
      version: "^0.8",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
