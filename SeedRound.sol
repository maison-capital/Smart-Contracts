// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) private pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


/**
 * @title PrivatePresale
 * @dev Private Presale smart contract, which calculates the amount of tokens to be claimed
 * based on the price of one token in relation to the deposit token
 */

contract SeedDistribution {

    using SafeERC20 for IERC20;

    // tgeHappened is required for token distribution to start
    /// @dev set to true when token generation event has happened, users can collect tokens only when true
    bool public tgeHappened;

    // tgeToCollect returns % of tokens to collect after TGE (11% = 11000)
    uint256 private tgeToCollect = 11000;

    // normalCollect returns % of tokens to collect after 1st collect (8.9% = 8900)
    uint256 private normalCollect = 8900;

    uint256 private seedPrice = 50;

    /// @dev used to return the amount of tokens to send to this SC for claim
    uint256 public amountOfTokensNeeded;

    /// @dev when tgeHappened sets to true, block.timestamp is stored
    uint256 private tgeTime;
    // Collect1 -> Collect10 – 2 weeks after each other (8.9% collect)
    uint256 private Collect1;
    uint256 private Collect2;
    uint256 private Collect3;
    uint256 private Collect4;
    uint256 private Collect5;
    uint256 private Collect6;
    uint256 private Collect7;
    uint256 private Collect8;
    uint256 private Collect9;
    uint256 private Collect10;

    // _depositToken Declares deposit token
    // 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56 - Mainnet BUSD Address
    // 0xeD24FC36d5Ee211Ea25A80239Fb8C4Cfd80f12Ee - Testnet BUSD Address
    IERC20 private immutable _depositToken = IERC20(0xeD24FC36d5Ee211Ea25A80239Fb8C4Cfd80f12Ee);

    // _returnToken Declares claim token
    // MSN-Testnet 0x2F8De05106132a363Ca261083D496cf1b5680cc1
    IERC20 private _returnToken;

    event OwnershipTransferred(address _previousOwner, address _newOwner);
    event OwnershipRenounced(address _previousOwner, address _newOwner);
    event AddressesAdded(uint256 _amount);

    address public owner;

    ///@dev Mapping of address -> struct
    mapping(address => presaleWallet) public inPresale;

    /// @param isWhiteListed - whether address is whitelisted (true or false)
    /// @param amount - amount of deposit token sent
    /// @param number - number of transactions from the wallet
    /// @param tokenAmount - initial amount of tokens to send based on amount of deposit token and presale price
    /// @param newAmount - number of tokens left to claim (decreases after claims)
    /// @param tgeCollect - amount of tokens to collect after TGE
    /// @param nrmCollect - amount of tokens to collect after tgeCollect
    /// @param numOfCollectTX increases by 1 after each collect (works from 0 to 10 (11 tx))
    struct presaleWallet {
        bool isWhiteListed;
        uint8 txCount;
        uint256 tokenAmount;
        uint256 newAmount;
        uint256 tgeCollect;
        uint256 nrmCollect;
        uint8 numOfCollectTX;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "OnlyOwner: You're not the owner");
        _;
    }

    constructor () {
        owner = msg.sender;
    }

    function setTokenAddress(IERC20 _token) public onlyOwner {
        _returnToken = _token;
    }

    function addAddresses(address[] memory _addresses, uint256[] memory _ammounts) public onlyOwner {
        uint256 countAddr = _addresses.length;
        uint256 countAmm = _ammounts.length;
        require(countAddr == countAmm, "Lengths are not matching");
        for (uint256 i = 0; i < countAddr; i++) {
            inPresale[_addresses[i]].isWhiteListed = true;
            uint256 _tokenAmount = _ammounts[i];
            inPresale[_addresses[i]].tokenAmount = (_tokenAmount*10**2)/seedPrice;
            inPresale[_addresses[i]].newAmount = (_tokenAmount*10**2)/seedPrice;
            inPresale[_addresses[i]].tgeCollect = (((_tokenAmount*10**2)/seedPrice)*tgeToCollect)/(1*10**5);
            inPresale[_addresses[i]].nrmCollect = (((_tokenAmount*10**2)/seedPrice)*normalCollect)/(1*10**5);
        }
        emit AddressesAdded(countAddr);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        address previousOwner = owner;
        owner = _newOwner;
        emit OwnershipTransferred(previousOwner, owner);
    }

    function renounceOwnership() public onlyOwner {
        address _previousOwner = owner;
        owner = address(0);
        emit OwnershipRenounced(_previousOwner, owner);
    }
    
    /// @return deposit token address
    function depositToken() public view virtual returns (IERC20) {
        return _depositToken;
    }
    
    /// @return presale token address
    function returnToken() public view virtual returns (IERC20) {
        return _returnToken;
    }

    /// @return collect times (9 values)
    function collectTimes() public view virtual returns (uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256, uint256) {
        require(tgeHappened == true, "TGE has not happened!");
        return(tgeTime, Collect1, Collect2, Collect3, Collect4, Collect5, Collect6, Collect7, Collect8, Collect9, Collect10);
    }

    
    // Withdraw deposit token by owner after presale
    /// @notice need to add to closePresale function
    function withdrawAnyToken(IERC20 _address) public onlyOwner {
        require(_address.balanceOf(address(this)) > 0, "No tokens to transfer");
        _address.safeTransfer(msg.sender, _address.balanceOf(address(this)));
    }

    
    /// @notice Sets tgeHappened to true and claimTokens() could be used
    function setTGEHappened() public onlyOwner {
        tgeHappened = true;
        tgeTime = block.timestamp;
        Collect1 = block.timestamp + 2 weeks;
        Collect2 = block.timestamp + 4 weeks;
        Collect3 = block.timestamp + 6 weeks;
        Collect4 = block.timestamp + 8 weeks;
        Collect5 = block.timestamp + 10 weeks;
        Collect6 = block.timestamp + 12 weeks;
        Collect7 = block.timestamp + 14 weeks;
        Collect8 = block.timestamp + 16 weeks;
        Collect9 = block.timestamp + 18 weeks;
        Collect10 = block.timestamp + 20 weeks;
    }
    
    function checkTime() internal view returns(uint8) {
        uint256 _currentTime = block.timestamp;
        if (_currentTime >= Collect1) {
            if (_currentTime >= Collect2) {
                if (_currentTime >= Collect3) {
                    if (_currentTime >= Collect4) {
                        if (_currentTime >= Collect5) {
                            if (_currentTime >= Collect6){
                                if (_currentTime >= Collect7) {
                                    if (_currentTime >= Collect8) {
                                        if (_currentTime >= Collect9) {
                                            if (_currentTime >= Collect10) {
                                                return 10;
                                            } else {
                                                return 9;
                                            }
                                        } else {
                                            return 8;
                                        }
                                    } else {
                                        return 7;
                                    }
                                } else {
                                    return 6;
                                }
                            } else {
                                return 5;
                            }
                        } else {
                            return 4;
                        }
                    } else {
                        return 3;
                    }
                } else {
                    return 2;
                }
            } else {
                return 1;
            }
        } else {
            return 0;
        }
    }
    
    /// @dev function to claim tokens after TGE has happened
    function claimTokens() public {
        require(tgeHappened == true, "Claim Error: TGE has not yet happened");
        require(inPresale[msg.sender].isWhiteListed, "Claim Error: You have not participated in presale");
        require(inPresale[msg.sender].numOfCollectTX <= 11,"Claim Error: You have claimed all tokens");
        uint8 _collectNumber = checkTime();
        if (_collectNumber == 0 && inPresale[msg.sender].numOfCollectTX == 0) {
            uint256 _amountToCollect = inPresale[msg.sender].tgeCollect;
            require(inPresale[msg.sender].newAmount >= _amountToCollect, "You have not enought tokens left");
            inPresale[msg.sender].newAmount -= _amountToCollect;
            inPresale[msg.sender].numOfCollectTX ++;
            returnToken().safeTransfer(msg.sender, _amountToCollect);
        } else if (_collectNumber > 0 && inPresale[msg.sender].numOfCollectTX == 0) {
            uint256 _amountToCollect = inPresale[msg.sender].nrmCollect*_collectNumber;
            _amountToCollect += inPresale[msg.sender].tgeCollect;
            require(inPresale[msg.sender].newAmount >= _amountToCollect, "You have not enought tokens left");
            inPresale[msg.sender].newAmount -= _amountToCollect;
            inPresale[msg.sender].numOfCollectTX += _collectNumber + 1;
            returnToken().safeTransfer(msg.sender, _amountToCollect);
        } else if (_collectNumber > 0 && inPresale[msg.sender].numOfCollectTX > 0) {
            uint8 _numberOfCollects = inPresale[msg.sender].numOfCollectTX;
            uint8 _leftCollects = _collectNumber - _numberOfCollects + 1;
            uint256 _amountToCollect = inPresale[msg.sender].nrmCollect*_leftCollects;
            require(inPresale[msg.sender].newAmount >= _amountToCollect, "You have not enought tokens left");
            inPresale[msg.sender].newAmount -= _amountToCollect;
            inPresale[msg.sender].numOfCollectTX += _leftCollects;
            returnToken().safeTransfer(msg.sender, _amountToCollect);
        } else {
            revert("Claim Error: Time for the next claim has not been reached");
        }
    }

    /// @notice Reverts if funds are sent directly to the smart contract
    receive() external payable {
        revert("ReceiveError: This Smart Contract cannot receive BNB");
    }

    fallback() external payable {
        revert("ReceiveError: This Smart Contract cannot receive money like this");
    }
}
