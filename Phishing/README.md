# Phishing (tx.origin)
The Wallet contract and the Attack contract can be used to re-generate the results of the phishing (tx.origin) attack using the steps discussed in the report. For ease of access the steps are listed here as well.
1. Open Remix IDE.
2. Add all the code in your smart contract and compile the contract with the option on the left navigation bar. The compiler shows all errors and warnings in the contract if any. 
3. After compilation, the contract is ready to be deployed. To deploy the contract shift to the deploy located right below the compiler option. First, ensure that the environment is “Injected Provider - Metamask” and your Metamask wallet is connected with the Remix IDE. Select the contract you want to deploy from the dropdown menu and deploy it.
4. Once the contract is deployed, you can scroll down on the same tab and see your deployed contract under the “Deployed Contracts” section. Expanding the contract tab will reveal all the functions you have in the contract, and from there, you can call those functions.
5. For the Attack contract, you have to specify the contract address of the EtherStore contract before deploying. You can copy the contract address of your EtherStore contract from the “Deployed contract” section and then paste it to the “At Address” field right above the deploy button.

The PreventsPhishing contract is the one free from the phishing (tx.origin) exploit.
