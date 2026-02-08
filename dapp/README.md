# Web3 Week (dApp)

dApp from project Webbb3.

## Project

<img src='src/img/vote-page.jpeg' alt='webbb3' title='webbb3' />

## Integrating to Wallet

In `dapp/src/Vote.tsx` replace the content of constant `CONTRACT_ADDRESS` by the contract address of you smart contract.

```typescript
...
export default function Vote() {

    const CONTRACT_ADDRESS = "0x0000000000000000000000000000000000000000";
    const config = useConfig();
    const [message, setMessage] = useState<string>("");
...
```

Copy the ABI of your smart contract and paste into `ABI.json` file.