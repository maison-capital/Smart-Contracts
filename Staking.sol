// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

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
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

contract Staking is Ownable {
    using SafeERC20 for IERC20;


    uint256 private startBlock;
    uint256 private endBlock;
    uint256 private lastDepositBlock;
    uint256 private totalTokens;
    uint256 private tokensPerBlock;
    uint256 private totalDeposited;
    uint256 private numberOfUsers;
    uint256 private lastCalculatedBlock;
    IERC20 private depositToken;
    IERC20 private rewardToken;
    uint256 precisionLevel = 1*10**18;

    address[] private allAddresses;

    struct userStruct {
        bool isInStaking;
        uint256 depositAmount;
        uint256 rewardDebt;
        uint256 claimTx;
        uint256 currentRewardPerBlock;
        uint256 depositBlock;
        uint256 unlockBlock;
    }

    mapping(address => userStruct) public stakingWallets;

    event DepositSuccessful(address _wallet, uint256 _amount);
    event WithdrawalSuccessful(address _wallet, uint256 _claimCycle, uint256 _amount);
    event HarvestSuccessfull(address _wallet, uint256 _amount);
    event RewardsRecalculated(bool _success);
    event HarvestReDeposited(address _wallet, uint256 _amount);

    constructor(uint256 _startBlock, uint256 _totalTokens, IERC20 _depositToken, IERC20 _rewardToken) {
        startBlock = _startBlock;
        endBlock = startBlock + 20*60*24*365*3; // 1 year is approx. 10512000 blocks
        totalTokens = _totalTokens;
        tokensPerBlock = totalTokens*precisionLevel / (20*60*24*365*3); // precision level??
        depositToken = _depositToken;
        rewardToken = _rewardToken;
        lastDepositBlock = endBlock - 20*60*24*80; // 1 months and 50 days
    }    

    function depToken() internal view returns (IERC20) {
        return depositToken;
    }

    function rewToken() internal view returns (IERC20) {
        return rewardToken;
    }

    function deposit(uint256 _amount) public {
        require(block.number >= startBlock, "Error: Deposits to this contract are not yet allowed");
        require(block.number <= lastDepositBlock, "Error: Deposits have finished");

        depToken().safeTransferFrom(msg.sender, address(this), _amount);
        _recalculateRewardForAllUsers();
        totalDeposited += _amount;
        if (!stakingWallets[msg.sender].isInStaking) {
            numberOfUsers ++;
            allAddresses.push(msg.sender);
        }
        stakingWallets[msg.sender].isInStaking = true;
        stakingWallets[msg.sender].depositAmount += _amount;
        stakingWallets[msg.sender].rewardDebt += 0;
        stakingWallets[msg.sender].claimTx = 0;
        stakingWallets[msg.sender].depositBlock = block.number;
        stakingWallets[msg.sender].unlockBlock = block.number + 20*60*24*30; // 30 days
        emit DepositSuccessful(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) public {
        _recalculateRewardForAllUsers();
        require(stakingWallets[msg.sender].isInStaking, "You have not staked anything");
        uint256 claimCycle = getClaimCycle(msg.sender);
        require(claimCycle > 0, "You have not yet reached unlock block");
        require(stakingWallets[msg.sender].claimTx < claimCycle, "Next claim cycle has not been reached");
        require(stakingWallets[msg.sender].claimTx <= 50, "You have already claimed everything");
        uint256 withdrawableAmount = getWithdrawableAmount(msg.sender);
        require(withdrawableAmount >= _amount, "You cannot withdraw that many tokens");
        totalDeposited -= _amount;
        stakingWallets[msg.sender].depositAmount -= _amount;
        if (stakingWallets[msg.sender].depositAmount == 0) {
            for (uint256 i = 0; i < allAddresses.length; i++) {
                if (allAddresses[i] == msg.sender) {
                    allAddresses[i] = allAddresses[allAddresses.length - 1];
                    allAddresses.pop();
                    stakingWallets[msg.sender].isInStaking = false;
                }
            }
        }
        _recalculateRewardForAllUsers();
        stakingWallets[msg.sender].claimTx = claimCycle; 
        uint256 _userRewardDebt = stakingWallets[msg.sender].rewardDebt;
        stakingWallets[msg.sender].rewardDebt = 0;
        rewToken().safeTransfer(msg.sender, _amount);
        rewToken().safeTransfer(msg.sender, _userRewardDebt);
        emit WithdrawalSuccessful(msg.sender , claimCycle, _amount);
        emit HarvestSuccessfull(msg.sender, _userRewardDebt);
    }

    function lastDepBlock() public view returns (uint256) {

    }

    function getWithdrawableAmount(address _address) public view returns(uint256) {
        uint256 claimCycle = getClaimCycle(_address);
        uint256 _userWithdrawableAmount = (stakingWallets[_address].depositAmount/50)*(claimCycle-stakingWallets[_address].claimTx);
        return _userWithdrawableAmount;
    }

    function getClaimCycle(address _address) internal view returns(uint256) {
        if (block.number > stakingWallets[_address].unlockBlock) {
            uint256 claimCycle = (block.number - stakingWallets[_address].unlockBlock) / 57600;
            if (claimCycle == 0) {
                return 1;
            } else {
                return claimCycle;
            }
        } else {
            return 0;
        }
    }

    function harvestAndRestake() public {
        _recalculateRewardForAllUsers();
        require(stakingWallets[msg.sender].isInStaking, "You have not staked anything");
        require(stakingWallets[msg.sender].rewardDebt > 0,"Nothing to claim");
        require(block.number <= lastDepositBlock, "Error: Deposits have finished");
        uint256 _amount = stakingWallets[msg.sender].rewardDebt;
        stakingWallets[msg.sender].rewardDebt = 0;
        totalDeposited += _amount;
        if (!stakingWallets[msg.sender].isInStaking) {
            numberOfUsers ++;
            allAddresses.push(msg.sender);
        }
        stakingWallets[msg.sender].isInStaking = true;
        stakingWallets[msg.sender].depositAmount += _amount;
        stakingWallets[msg.sender].claimTx = 0;
        stakingWallets[msg.sender].depositBlock = block.number;
        stakingWallets[msg.sender].unlockBlock = block.number + 20*60*24*30; // 30 days
        emit HarvestReDeposited(msg.sender, _amount);
    }

    function harvest() public {
        _recalculateRewardForAllUsers();
        require(stakingWallets[msg.sender].isInStaking, "You have not staked anything");
        require(stakingWallets[msg.sender].rewardDebt > 0,"Nothing to claim");
        uint256 toHarvest = stakingWallets[msg.sender].rewardDebt;
        stakingWallets[msg.sender].rewardDebt = 0;
        rewToken().safeTransfer(msg.sender, toHarvest);
        emit HarvestSuccessfull(msg.sender, toHarvest);
    }

    function recalculateReward() public {
        _recalculateRewardForAllUsers();
        emit RewardsRecalculated(true);
    }

    function getAPR(uint256 _depAmount) public view returns (uint256) {
        uint256 _apr = ((tokensPerBlock*10**3)*_depAmount*10512000)/(totalDeposited+(_depAmount*10**18));
        return _apr;
    }

    function getTotalDeposited() public view returns (uint256) {
        return totalDeposited;
    }

    function getUserDeposit(address _user) public view returns (uint256) {
        return stakingWallets[_user].depositAmount;
    }

    function getUserRewardDebt(address _user) public view returns (uint256) {
        return stakingWallets[_user].rewardDebt;
    }

    function getEndBlock() public view returns (uint256) {
        return endBlock;
    }

    function getLastDepositBlock() public view returns (uint256) {
        return lastDepositBlock;
    }

    function _recalculateRewardForAllUsers() internal {
        uint256 blocksPassed = block.number - lastCalculatedBlock;
        for (uint256 i = 0; i<numberOfUsers; i++) {
            uint256 _oldRewardPerBlock = _calculateUserRewardPerBlock(allAddresses[i]);
            stakingWallets[allAddresses[i]].currentRewardPerBlock = _oldRewardPerBlock;
            stakingWallets[allAddresses[i]].rewardDebt += _oldRewardPerBlock*blocksPassed/precisionLevel;
        }
        lastCalculatedBlock = block.number;
    }

    function _calculateUserRewardPerBlock(address _address) view internal returns(uint256) {
        uint256 _percentRewardForUser = stakingWallets[_address].depositAmount*precisionLevel/totalDeposited;
        uint256 _rewardForUser = _percentRewardForUser*tokensPerBlock/precisionLevel; //tokensPerBlock has precision multiplier
        return _rewardForUser;  // Reward is returned with 10**18 at the end (which is more than tokens to claim)
    }
    
    function emergencyWithdrawal() public onlyOwner {
        depToken().safeTransfer(owner(), depToken().balanceOf(address(this)));
        rewToken().safeTransfer(owner(), rewToken().balanceOf(address(this)));
    }

}