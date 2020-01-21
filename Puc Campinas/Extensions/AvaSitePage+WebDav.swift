//
//  AvaSitePage+WebDav.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 20/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import PuccSwift

extension AvaSitePage {
    public var resourceUrl: String? {
        guard let siteID = siteID else { return nil }
        return "http://ead.puc-campinas.edu.br/dav/\(siteID)"
    }
    
    public var dropboxUrl: String? {
        guard let siteID = siteID else { return nil }
        return "http://ead.puc-campinas.edu.br/dav/group-user/\(siteID)/\(PucConfiguration.shared.username)"
    }
    
    public var toolID: SakaiTool? {
        guard let toolID = self.tools?[0].toolID, let sakaiTool = SakaiTool(toolID: toolID) else { return nil }
        return sakaiTool
    }
}
