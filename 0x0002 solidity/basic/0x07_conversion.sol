// SPDX-License-Identifier: PDX-3.0
pragma solidity ^0.8.0;

/*
@类型转换
-   介绍
    solidity需要类型转换的场景有几个：
        -   变量赋值
        -   函数传参
        -   使用操作符
    分两种：
    -   隐式转换：前提是不能导致信息丢失，所以只能是小类型转大类型、窄类型转宽类型；
        -   如任何可以转换uint160的类型都可转换为address类型
    -   显式转换：手工转换，可能导致信息丢失，如位数阶段、无法覆盖导致的溢出，不过在v0.8.0及以上版本，这种会导致信息丢失的显式转换的代码无法编译通过！

    -   以上转换都不允许正类型转全类型(即使能够覆盖)，如uint8 => int32
*/


contract LearnConvert{
    constructor(){
        // 隐式转换：没有使用类型构造函数就是隐式转换
        uint8 i = 1;
        uint256 u256 = i+1;
        require(u256 > 0);
        // int32 i32 = i+1; // v0.8.0以后不允许正类型转全类型，显式也不行
        int8 i8 = 1;
        int32 _i32 = i8 + 1;
        require(_i32 > 0);

        // 显式转换
        uint8 u8 = 0x11;
        // int256 i256 = int256(u8) + 1; // 正类型不能转负类型
        uint32 u32 = uint32(u8); // 正类型 可以小转大，在高位填充0 = 0x00000011
        require(u32 == 0x00000011);
        // u256 = uint256(i8); // i8在v0.8.0以后不能转换uintx了
        // u8 = uint256(u8);  // 正类型 不可大转小

        bytes2 b2 = 0x1234;
        bytes1 b1 = bytes1(b2);  // 字节数组 大转小，截断后面的
        require(b1 == 0x12);
        bytes3 b3 = bytes3(b2); // 小转大，后面填充0
        require(b3 == 0x123400);

        // u8 = 0x1111; // 字面量创建变量 不能超出范围
    }
}