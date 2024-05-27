Installed Chainlink ccip module with

```
forge install smartcontractkit/ccip@b06a3c2eecb9892ec6f76a015624413fffa1a122
```

with remapping of

remappings = ["@chainlink/contracts-ccip/=lib/ccip/contracts/"]

#

deploy gofundme (avalance); 0x8437298aoeung9823

EVM chains delar på samma public address

Sender contract (router, address, amount)
deployer för sender <---> msg.sender
deployer för reciever
reciever contrat (router, address)
---> chainlinks blockkedja (sender <----> reciever) Chainlink explorer)
Sepolia ---> avalance testnet

deployer efter usdc tagits emot skicka till gofundme.

reciever tagit emot usdc
(usdc) ---> gofundme Contract

gofundme (amount) (håller koll på. Vem som skickade, hur mycket den skickade osv)

msg.sender (amount från kedja till gofundme)

#

#
