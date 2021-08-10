# Maison Capital Smart Contracts

<h3>MSNToken.sol</h3>

**Name:** Maison Capital<br>
**Symbol:** MSN<br>
**Total Supply:** 10.000.000<br>
**Decimals:** 18<br>
**Fee:** 3% (from each tx):


<ul>
  <li>Dev Fund Fee: 1%</li>
  <li>Investment Fee: 0.5%</li>
  <li>Farming And Staking Fee: 1%</li>
  <li>Burn: 0.5%</li>
</ul>
<hr>
<h3>Presale.sol</h3>
<br>
Private Presale smart contract.<br>
To use:
<ol>
  <li>Call approve(uint256(-1)) to BUSD Smart Contract</li>
  <li>Send _value to privatePresale at Presale Smart Contract</li>
</ol>
<hr>
<h3>SeedRound.sol</h3>
<br>
Seed Round distribution smart contract.<br>
To use:
<ol>
  <li>Call addAddresses with (addresses[], amount[])</li>
  <ul>
    <li>amount with 18 zeros at the end</li>
  </ul>
  <li>Claim through claimTokens()</li>
</ol>
<hr>
<h3>DevFund.sol</h3>
Developers are assigned salaries (isDeveloper[address].montlyAllowance)<br>
Developer can claim every 30 days through claim()<br>
**Initial Supply:** 1M tokens<br>
**Total Supply:** Initial + 0.5% TX fee
<hr>
<h3>MarketingFund.sol</h3>
One address can claim monthly allowance from the Smart Contract<br>
**Total**: 1.5M Tokens<br>
**Vesting**: 10% per month for 10 months
