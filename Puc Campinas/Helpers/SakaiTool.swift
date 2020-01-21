//
//  SakaiTool.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 21/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import Foundation

public enum SakaiTool {
    /// Used at "Home" page
    case site
    /// Used for "Agenda" page
    case schedule
    /// Used for "Atividades" page
    case assignmentGrades
    /// Used for "Chat" page
    case announcements
    /// Used for "Chat" page
    case chat
    /// Used for "E-mail" page
    case messages
    /// Used for "Escaninho" page
    case dropbox
    /// Used for "Exercícios" page
    case samigo
    /// Used for "Estatísticas" page
    case sitestats
    /// Used for "Forum" page
    case forums
    /// Used for "Manual do professor" page
    case iFrame
    /// Used for "Materiais" page
    case melete
    /// Used for "Plano de Ensino" page
    case syllabus
    /// Used for "Participantes" page
    case siteRoster
    /// Used for "Quadro de Notas" page
    case gradebookTool
    /// Used for "Repositório" page
    case resources
    /// Used for "Site Info" page
    case siteinfo
    /// Used for "Suporte"
    case iFrameService
    
    init?(toolID: String) {
        switch toolID {
        case "sakai.iframe.site":
            self = .site
        case "sakai.schedule":
            self = .schedule
        case "sakai.assignment.grades":
            self = .assignmentGrades
        case "sakai.announcements":
            self = .announcements
        case "sakai.chat":
            self = .chat
        case "sakai.messages":
            self = .messages
        case "sakai.dropbox":
            self = .dropbox
        case "sakai.samigo":
            self = .samigo
        case "sakai.sitestats":
            self = .sitestats
        case "sakai.iframe.forums":
            self = .forums
        case "sakai.iframe":
            self = .iFrame
        case "sakai.melete":
            self = .melete
        case "sakai.syllabus":
            self = .syllabus
        case "sakai.site.roster":
            self = .siteRoster
        case "sakai.gradebook.tool":
            self = .gradebookTool
        case "sakai.resources":
            self = .resources
        case "sakai.siteinfo":
            self = .siteinfo
        case "sakai.iframe.service":
            self = .iFrameService
        default:
            return nil
        }
    }
}
