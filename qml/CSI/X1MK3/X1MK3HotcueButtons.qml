import CSI 1.0
import QtQuick 2.12
import "Defines"

Module
{
  id: module
  property bool shift: false
  property bool active: false
  property int deckIdx: 0
  property string surface: ""

  property int hotcue12PushAction: 0
  property int hotcue34PushAction: 0
  property int hotcue12ShiftPushAction: 0
  property int hotcue34ShiftPushAction: 0

  Hotcues { name: "hotcues"; channel: module.deckIdx }
  RemixDeckSlots { name: "remix_slots"; channel: module.deckIdx }
  ButtonTempoBend { name: "tempo_bend"; channel: module.deckIdx }

  function hotcueTypeToLED(hotcueType) {
    if (hotcueType == 0) return Color.Turquoise
    else if (hotcueType == 1) return Color.DarkOrange
    else if (hotcueType == 2) return Color.Red
    else if (hotcueType == 3) return Color.Yellow
    else if (hotcueType == 4) return Color.White
    else if (hotcueType == 5) return Color.Green
    else return Color.Black
  }

  AppProperty { id: deckTypeProp; path: "app.traktor.decks." + module.deckIdx + ".type" }

  AppProperty { id: hotcue1Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.1.type" }
  AppProperty { id: hotcue2Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.2.type" }
  AppProperty { id: hotcue3Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.3.type" }
  AppProperty { id: hotcue4Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.4.type" }
  AppProperty { id: hotcue5Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.5.type" }
  AppProperty { id: hotcue6Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.6.type" }
  AppProperty { id: hotcue7Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.7.type" }
  AppProperty { id: hotcue8Type; path: "app.traktor.decks." + module.deckIdx + ".track.cue.hotcues.8.type" }

  // DUPLICATE DECK
  
  Timer {
    id: duplicateSelectionTimer
    property bool blink: false
    interval: 250
    repeat:   true
    running: duplicateDeckSourceIDProp.value != 0
    onTriggered: {
      blink = !blink;
    }
    onRunningChanged: {
      blink = running
    }
  }

  WiresGroup {
    enabled: module.active && customBrowserModeProp.value && browserModeProp.value
    
    WiresGroup {
      enabled: (deckTypeProp1.value % 2 == 0)
      
      Wire {
        from: "%surface%.hotcues.1";  
        to: ButtonScriptAdapter {
          brightness: ( (duplicateDeckSourceIDProp.value != 1) && deckIsPlayingProp1.value ) || ( (duplicateDeckSourceIDProp.value == 1) && duplicateSelectionTimer.blink ) ? 1.0 : 0.0
          color: Color.White
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value == 0) && deckIsLoaded1.value
        from: "%surface%.hotcues.1.value";  
        to: ButtonScriptAdapter {
          onPress: duplicateDeckSourceIDProp.value = 1
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value != 0)
        from: "%surface%.hotcues.1.value";  
        to: ButtonScriptAdapter {
          onPress: {
            if (duplicateDeckSourceIDProp.value == 2) {
              duplicateToDeck1FromDeck2.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 3) {
              duplicateToDeck1FromDeck3.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 4) {
              duplicateToDeck1FromDeck4.value = true
            }
            else duplicateDeckSourceIDProp.value = 0
          }
          onRelease: {
            if (duplicateDeckSourceIDProp.value != 1) duplicateDeckSourceIDProp.value = 0
          }
        }
      }
      
    }

    WiresGroup {
      enabled: (deckTypeProp2.value % 2 == 0)
      
      Wire {
        from: "%surface%.hotcues.2";  
        to: ButtonScriptAdapter {
          brightness: ( (duplicateDeckSourceIDProp.value != 2) && deckIsPlayingProp2.value ) || ( (duplicateDeckSourceIDProp.value == 2) && duplicateSelectionTimer.blink ) ? 1.0 : 0.0
          color: Color.White
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value == 0) && deckIsLoaded2.value
        from: "%surface%.hotcues.2.value";  
        to: ButtonScriptAdapter {
          onPress: duplicateDeckSourceIDProp.value = 2
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value != 0)
        from: "%surface%.hotcues.2.value";  
        to: ButtonScriptAdapter {
          onPress: {
            if (duplicateDeckSourceIDProp.value == 1) {
              duplicateToDeck2FromDeck1.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 3) {
              duplicateToDeck2FromDeck3.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 4) {
              duplicateToDeck2FromDeck4.value = true
            }
            else duplicateDeckSourceIDProp.value = 0
          }
          onRelease: {
            if (duplicateDeckSourceIDProp.value != 2) duplicateDeckSourceIDProp.value = 0
          }
        }
      }
      
    }

    WiresGroup {
      enabled: (deckTypeProp3.value % 2 == 0)
      
      Wire {
        from: "%surface%.hotcues.3";  
        to: ButtonScriptAdapter {
          brightness: ( (duplicateDeckSourceIDProp.value != 3) && deckIsPlayingProp3.value ) || ( (duplicateDeckSourceIDProp.value == 3) && duplicateSelectionTimer.blink ) ? 1.0 : 0.0
          color: Color.White
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value == 0) && deckIsLoaded3.value
        from: "%surface%.hotcues.3.value";  
        to: ButtonScriptAdapter {
          onPress: duplicateDeckSourceIDProp.value = 3
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value != 0)
        from: "%surface%.hotcues.3.value";  
        to: ButtonScriptAdapter {
          onPress: {
            if (duplicateDeckSourceIDProp.value == 1) {
              duplicateToDeck3FromDeck1.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 2) {
              duplicateToDeck3FromDeck2.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 4) {
              duplicateToDeck3FromDeck4.value = true
            }
            else duplicateDeckSourceIDProp.value = 0
          }
          onRelease: {
            if (duplicateDeckSourceIDProp.value != 3) duplicateDeckSourceIDProp.value = 0
          }
        }
      }
      
    }

    WiresGroup {
      enabled: (deckTypeProp4.value % 2 == 0)
      
      Wire {
        from: "%surface%.hotcues.4";  
        to: ButtonScriptAdapter {
          brightness: ( (duplicateDeckSourceIDProp.value != 4) && deckIsPlayingProp4.value ) || ( (duplicateDeckSourceIDProp.value == 4) && duplicateSelectionTimer.blink ) ? 1.0 : 0.0
          color: Color.White
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value == 0) && deckIsLoaded4.value
        from: "%surface%.hotcues.4.value";  
        to: ButtonScriptAdapter {
          onPress: duplicateDeckSourceIDProp.value = 4
        }
      }
      Wire {
        enabled: (duplicateDeckSourceIDProp.value != 0)
        from: "%surface%.hotcues.4.value";  
        to: ButtonScriptAdapter {
          onPress: {
            if (duplicateDeckSourceIDProp.value == 1) {
              duplicateToDeck4FromDeck1.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 2) {
              duplicateToDeck4FromDeck2.value = true
            }
            else if (duplicateDeckSourceIDProp.value == 3) {
              duplicateToDeck4FromDeck3.value = true
            }
            else duplicateDeckSourceIDProp.value = 0
          }
          onRelease: {
            if (duplicateDeckSourceIDProp.value != 4) duplicateDeckSourceIDProp.value = 0
          }
        }
      }

    }
    
  }

  WiresGroup
  {
    enabled: module.active && !(customBrowserModeProp.value && browserModeProp.value)

    WiresGroup
    { 
      enabled: (deckTypeProp.value == DeckType.Track || deckTypeProp.value == DeckType.Stem) // && module.active 

      // Hotcue buttons 1-2
      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_12)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_12))
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.1.trigger" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.2.trigger" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 0; color: hotcueTypeToLED(hotcue1Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 1; color: hotcueTypeToLED(hotcue2Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_34)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_34))
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.3.trigger" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.4.trigger" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 2; color: hotcueTypeToLED(hotcue3Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 3; color: hotcueTypeToLED(hotcue4Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_56)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_56))
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.5.trigger" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.6.trigger" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 4; color: hotcueTypeToLED(hotcue5Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 5; color: hotcueTypeToLED(hotcue6Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_78)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_78))
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.7.trigger" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.8.trigger" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 6; color: hotcueTypeToLED(hotcue7Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 7; color: hotcueTypeToLED(hotcue8Type.value) } }
      }

      WiresGroup
      {
        enabled: !module.shift && (hotcue12PushAction == HotcueAction.tempo_bend)

        Wire { from: "%surface%.hotcues.1"; to: "tempo_bend.down" }
        Wire { from: "%surface%.hotcues.2"; to: "tempo_bend.up" }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_12)
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.1.delete" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.2.delete" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 0; color: hotcueTypeToLED(hotcue1Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 1; color: hotcueTypeToLED(hotcue2Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_34)
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.3.delete" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.4.delete" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 2; color: hotcueTypeToLED(hotcue3Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 3; color: hotcueTypeToLED(hotcue4Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_56)
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.5.delete" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.6.delete" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 4; color: hotcueTypeToLED(hotcue5Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 5; color: hotcueTypeToLED(hotcue6Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_78)
    
        // Wire { from: "%surface%.hotcues.1"; to: "hotcues.7.delete" }
        // Wire { from: "%surface%.hotcues.2"; to: "hotcues.8.delete" }
        Wire { from: "%surface%.hotcues.1"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 6; color: hotcueTypeToLED(hotcue7Type.value) } }
        Wire { from: "%surface%.hotcues.2"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 7; color: hotcueTypeToLED(hotcue8Type.value) } }
      }

      // Hotcue buttons 3-4
      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_12)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_12))
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.1.trigger" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.2.trigger" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 0; color: hotcueTypeToLED(hotcue1Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 1; color: hotcueTypeToLED(hotcue2Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_34)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_34))
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.3.trigger" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.4.trigger" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 2; color: hotcueTypeToLED(hotcue3Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 3; color: hotcueTypeToLED(hotcue4Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_56)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_56))
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.5.trigger" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.6.trigger" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 4; color: hotcueTypeToLED(hotcue5Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 5; color: hotcueTypeToLED(hotcue6Type.value) } }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_78)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_78))
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.7.trigger" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.8.trigger" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 6; color: hotcueTypeToLED(hotcue7Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.select_or_set_hotcue"; value: 7; color: hotcueTypeToLED(hotcue8Type.value) } }
      }

      WiresGroup
      {
        enabled: !module.shift && (hotcue34PushAction == HotcueAction.tempo_bend)

        Wire { from: "%surface%.hotcues.3"; to: "tempo_bend.down" }
        Wire { from: "%surface%.hotcues.4"; to: "tempo_bend.up"   }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_12)
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.1.delete" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.2.delete" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 0; color: hotcueTypeToLED(hotcue1Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 1; color: hotcueTypeToLED(hotcue2Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_34)
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.3.delete" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.4.delete" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 2; color: hotcueTypeToLED(hotcue3Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 3; color: hotcueTypeToLED(hotcue4Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_56)
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.5.delete" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.6.delete" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 4; color: hotcueTypeToLED(hotcue5Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 5; color: hotcueTypeToLED(hotcue6Type.value) } }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_78)
    
        // Wire { from: "%surface%.hotcues.3"; to: "hotcues.7.delete" }
        // Wire { from: "%surface%.hotcues.4"; to: "hotcues.8.delete" }
        Wire { from: "%surface%.hotcues.3"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 6; color: hotcueTypeToLED(hotcue7Type.value) } }
        Wire { from: "%surface%.hotcues.4"; to: HoldPropertyAdapter { path: "app.traktor.decks." + module.deckIdx + ".track.cue.delete_hotcue"; value: 7; color: hotcueTypeToLED(hotcue8Type.value) } }
      }
    }

    WiresGroup
    {
      enabled: (deckTypeProp.value == DeckType.Remix) // && module.active 

      // Hotcue buttons 1-2
      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_12)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_12))
    
        Wire { from: "%surface%.hotcues.1"; to: "remix_slots.1.adaptive_primary" }
        Wire { from: "%surface%.hotcues.2"; to: "remix_slots.2.adaptive_primary" }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue12PushAction == HotcueAction.trigger_34)) || (module.shift && (hotcue12ShiftPushAction == HotcueAction.trigger_34))
    
        Wire { from: "%surface%.hotcues.1"; to: "remix_slots.3.adaptive_primary" }
        Wire { from: "%surface%.hotcues.2"; to: "remix_slots.4.adaptive_primary" }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_12)
    
        Wire { from: "%surface%.hotcues.1"; to: "remix_slots.1.adaptive_secondary" }
        Wire { from: "%surface%.hotcues.2"; to: "remix_slots.2.adaptive_secondary" }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue12ShiftPushAction == HotcueAction.delete_34)
    
        Wire { from: "%surface%.hotcues.1"; to: "remix_slots.3.adaptive_secondary" }
        Wire { from: "%surface%.hotcues.2"; to: "remix_slots.4.adaptive_secondary" }
      }

      // Hotcue buttons 3-4
      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_12)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_12))
    
        Wire { from: "%surface%.hotcues.3"; to: "remix_slots.1.adaptive_primary" }
        Wire { from: "%surface%.hotcues.4"; to: "remix_slots.2.adaptive_primary" }
      }

      WiresGroup
      {
        enabled: (!module.shift && (hotcue34PushAction == HotcueAction.trigger_34)) || (module.shift && (hotcue34ShiftPushAction == HotcueAction.trigger_34))
    
        Wire { from: "%surface%.hotcues.3"; to: "remix_slots.3.adaptive_primary" }
        Wire { from: "%surface%.hotcues.4"; to: "remix_slots.4.adaptive_primary" }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_12)
    
        Wire { from: "%surface%.hotcues.3"; to: "remix_slots.1.adaptive_secondary" }
        Wire { from: "%surface%.hotcues.4"; to: "remix_slots.2.adaptive_secondary" }
      }

      WiresGroup
      {
        enabled: module.shift && (hotcue34ShiftPushAction == HotcueAction.delete_34)
    
        Wire { from: "%surface%.hotcues.3"; to: "remix_slots.3.adaptive_secondary" }
        Wire { from: "%surface%.hotcues.4"; to: "remix_slots.4.adaptive_secondary" }
      }
      
    }
    
  }
  
}
