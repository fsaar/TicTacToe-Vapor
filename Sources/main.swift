import Vapor

enum TTTError : Error {
    case InvalidRequest
}

let drop = Droplet()
drop.get("/config") { request in
    guard let query = request.uri.query , query.characters.count == 9  else {
        throw TTTError.InvalidRequest
    }
    let config = TTTBoardConfig(configString: query)
    let isRed = config.greenCount > config.redCount
    let machinePosition = config.winningMove(forPartySelectingRed: isRed) ??
        config.defenseMove(forPartySelectingRed: isRed) ??
        config.attackMove(forPartySelectingRed: isRed)
    var states = config.states
    states[machinePosition!.toIndex()] = isRed ? TTTState.redSelected : TTTState.greenSelected
    let newConfig = TTTBoardConfig(states: states)
    return newConfig.configString
}
drop.get("/") { request in
    let help = ["Available methods:","/config","\n"]
    let helpString = help.joined(separator: "\n")
    return helpString
}
drop.serve()
 
