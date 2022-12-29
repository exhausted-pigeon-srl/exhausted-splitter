object "XPSplitter" {
    code {
        // Deploy the contract
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            // This is only a fallback, irregardless of calldata
            let exhaustedPigeonAddress := 0x6C4dc45b51bB46A60B99fB5395692ce11bBE49C5
            let clientAddress := 0x3443d0a6956e7E0A13Cd1c54F6bEf24B0d54f420

            // 4% cut
            let ClientCut := div(mul(callvalue(), 400), 10000)
            pop(call(0, clientAddress, ClientCut, 0, 0, 0, 0))
            pop(call(0, exhaustedPigeonAddress, sub(callvalue(), ClientCut), 0, 0, 0, 0))
        }
    }
}