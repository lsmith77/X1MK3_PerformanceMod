import CSI 1.0
import QtQuick 2.0

import "Defines"

// X1MK3_TP4.5.0_PerformanceMod_13

Mapping
{
  id: mapping
  readonly property string propertiesPath: "mapping.state"
  // readonly property string settingsPath: "mapping.settings"

  X1MK3 { name: "surface" }

  X1MK3DeviceSetup {
    id: deviceSetup;
    name: "device_setup";

    surface: "surface";
    propertiesPath: mapping.propertiesPath
    shift: shiftProp.value
    // settingsPath: mapping.settingsPath
  }

  onRunningChanged:
  {
    // When the mapping is reloaded go back into device setup
    deviceSetup.reset();
    // deviceSetup.resetOverlayOvermapping();
  }

  // KontrolScreen { name: "screen"; side: ScreenSide.Left; propertiesPath: mapping.propertiesPath; flavor: ScreenFlavor.X1MK3_Mode }
  KontrolScreen { name: "screen"; propertiesPath: mapping.propertiesPath; flavor: ScreenFlavor.X1MK3_Mode }
  Wire { from: "screen.output"; to: "surface.display.mode" }

  // Custom Settings
  // MappingPropertyDescriptor { id: lastTouchedButtonLeftSideProp; path: "mapping.state.left.fx.last_active_button"; type: MappingPropertyDescriptor.Integer; value: 0 }
  // MappingPropertyDescriptor { id: lastTouchedButtonRightSideProp; path: "mapping.state.right.fx.last_active_button"; type: MappingPropertyDescriptor.Integer; value: 0 }
  MappingPropertyDescriptor {
    id: lastTouchedButtonLeftSideProp
    path: "mapping.state.left.fx.last_active_button"
    type: MappingPropertyDescriptor.Integer
    value: 0
    min: 0
    max: 20
  }
  
  MappingPropertyDescriptor {
    id: lastTouchedButtonRightSideProp
    path: "mapping.state.right.fx.last_active_button"
    type: MappingPropertyDescriptor.Integer
    value: 0
    min: 0
    max: 20
  }

  MappingPropertyDescriptor {
    id: deckAssignmentProp
    path: "mapping.settings.deck_assignment"
    type: MappingPropertyDescriptor.Integer
    value: DeviceAssignment.decks_a_b
    min: DeviceAssignment.decks_a_b
    max: DeviceAssignment.decks_a_c
    onValueChanged: {
      lastTouchedButtonLeftSideProp.value = 0
      lastTouchedButtonRightSideProp.value = 0
      if (value == DeviceAssignment.decks_a_b) customDeckSwitchAcVariantProp.value = false
      else if (value == DeviceAssignment.decks_c_d) customDeckSwitchAcVariantProp.value = false
      else if (value == DeviceAssignment.decks_c_a) customDeckSwitchAcVariantProp.value = false
      else if (value == DeviceAssignment.decks_a_c) customDeckSwitchAcVariantProp.value = true

      if (fxMode.value == FxMode.TwoFxUnits) fxAssignmentProp.value = DeviceAssignment.fx_1_2
      else if (customLinkFXOverlayToDeckProp.value) fxAssignmentProp.value = value

      deviceSetup.resetOverlayOvermapping()
    }
  }

  MappingPropertyDescriptor {
    id: fxAssignmentProp
    path: "mapping.settings.fx_assignment"
    type: MappingPropertyDescriptor.Integer
    value: DeviceAssignment.fx_1_2
    min: DeviceAssignment.fx_1_2
    max: DeviceAssignment.fx_1_3
    onValueChanged: {
      lastTouchedButtonLeftSideProp.value = 0
      lastTouchedButtonRightSideProp.value = 0
      deviceSetup.resetOverlayOvermapping()
    }
  }

  MappingPropertyDescriptor {
    id: customDeckSwitchAcVariantProp
    path: "mapping.settings.custom_deck_switch_ac_variant"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }


  // MIXER SETTINGS
  
  MappingPropertyDescriptor {
    id: customKnobAssignmentEqHigh
    path: "mapping.settings.custom_mixer_eq_high_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 1 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentEqHigh
    path: "mapping.settings.custom_mixer_eq_high_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentEqMid
    path: "mapping.settings.custom_mixer_eq_mid_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 2 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentEqMid
    path: "mapping.settings.custom_mixer_eq_mid_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentEqMidLow
    path: "mapping.settings.custom_mixer_eq_midlow_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentEqMidLow
    path: "mapping.settings.custom_mixer_eq_midlow_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentEqLow
    path: "mapping.settings.custom_mixer_eq_low_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 3 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentEqLow
    path: "mapping.settings.custom_mixer_eq_low_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentVolume
    path: "mapping.settings.custom_mixer_volume_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 4 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentVolume
    path: "mapping.settings.custom_mixer_volume_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentGain
    path: "mapping.settings.custom_mixer_gain_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentGain
    path: "mapping.settings.custom_mixer_gain_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customKnobAssignmentMixerFx
    path: "mapping.settings.custom_mixer_fx_knob_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // Knobs 1 to 4, 0 = not assigned
    min: 0
    max: 4
  }

  MappingPropertyDescriptor {
    id: customLayerAssignmentMixerFx
    path: "mapping.settings.custom_mixer_fx_knob_layer_assignment"
    type: MappingPropertyDescriptor.Integer
    value: 0 // 0 = both layers, 1 = noShift layer, 2 = Shift layer
    min: 0
    max: 2
  }

  MappingPropertyDescriptor {
    id: customMixerOverlayBlockProp
    path: "mapping.settings.custom_mixer_overlay_block"
    type: MappingPropertyDescriptor.Boolean
    value: false
    onValueChanged: {
      if (fx_section.layer == FXSectionLayer.mixer) {
        fx_section.layer = FXSectionLayer.fx_primary
      }
    }
  }
  
  
  // BROWSER SETTINGS

  MappingPropertyDescriptor {
    id: customBrowserModeProp
    path: "mapping.settings.custom_browser_mode"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: maximizeBrowserWhenBrowsingProp
    path: "mapping.settings.maximize_browser_when_browsing"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: minimizeBrowserWhenLoadingProp
    path: "mapping.settings.minimize_browser_when_loading"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  
  
  // BEAT COUNTER
  
  MappingPropertyDescriptor {
    id: deckDisplayMainInfoProp;
    path: "mapping.settings.deck_display.main_info";
    type: MappingPropertyDescriptor.Integer;
    value: 0 /* Remaining Time Display*/
  }
  MappingPropertyDescriptor {
    id: customBeatCounterEngagedProp
    path: "mapping.settings.custom_beatcounter_engaged"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: customBeatCounterPhraseLengthProp
    path: "mapping.settings.custom_phrase_length"
    type: MappingPropertyDescriptor.Integer
    value: 2 // 1, 2, 4, 8, 16, 32, 64 beats
    min: 0 // off, i.e. 'bars.beats' instead of 'phrases.bars.beats'
    max: 6 // 64 beats
  }


  // MISCELLANEOUS SETTINGS
  
  MappingPropertyDescriptor {
    id: customDeckSwitchOnSingleClickProp
    path: "mapping.settings.custom_deck_switch_on_single_click"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  
  MappingPropertyDescriptor {
    id: customSingleCueMonitorProp
    path: "mapping.settings.custom_single_cue_monitor"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: customSubchannelMuteSendFXProp
    path: "mapping.settings.custom_subchannel_mute_send_fx"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: customInvertMixerFxLedProp
    path: "mapping.settings.custom_invert_mixerfx_led"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  
  MappingPropertyDescriptor {
    id: customOvermappingEngagedProp
    path: "mapping.settings.custom_overmapping_engaged"
    type: MappingPropertyDescriptor.Boolean
    value: false
    onValueChanged: {
      if (value) {
        remixPageDeckA.value = 3
        remixPageDeckB.value = 3
      }
      else {
        remixPageDeckA.value = 0
        remixPageDeckB.value = 0
      }
    }
  }


  // TRANSPORT SETTINGS
  
  MappingPropertyDescriptor {
    id: customCueAndPlayProp
    path: "mapping.settings.custom_cue_and_play"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: customBeatJumpLengthProp
    path: "mapping.settings.custom_beatjump_length"
    type: MappingPropertyDescriptor.Integer
    value: 12 // 1, 2, 4, 8, 16, 32, Loop Length beats
    min: 6 // 1 beat
    max: 12 // Loop Length beats
  }
  MappingPropertyDescriptor {
    id: customEncoderTempoStepSizeProp
    path: "mapping.settings.custom_encoder_tempo_step_size"
    type: MappingPropertyDescriptor.Integer
    value: 1 // BPM
    min: 1
    max: 100
  }
  MappingPropertyDescriptor {
    id: customEncoderHoldTempoStepSizeProp
    path: "mapping.settings.custom_encoder_hold_tempo_step_size"
    type: MappingPropertyDescriptor.Integer
    value: 100 // BPM
    min: 1
    max: 100
  }
  
  
  // EFFECTS
  
  MappingPropertyDescriptor {
    id: customFxAssignmentsUnitFocusProp
    path: "mapping.settings.custom_fx_assignments_unit_focus"
    type: MappingPropertyDescriptor.Boolean
    value: false
  }
  MappingPropertyDescriptor {
    id: customLinkFXOverlayToDeckProp
    path: "mapping.settings.custom_link_fx_overlay_to_deck"
    type: MappingPropertyDescriptor.Boolean
    value: false
    onValueChanged: {
      if (value == true) {
        if (fxMode.value == FxMode.TwoFxUnits) {
          fxAssignmentProp.value = DeviceAssignment.fx_1_2
        }
        else if (fxAssignmentProp.value != deckAssignmentProp.value) fxAssignmentProp.value = deckAssignmentProp.value
        if (fx_section.layer == FXSectionLayer.fx_secondary) {
          fx_section.layer = FXSectionLayer.fx_primary
        }
      }
    }
  }
  MappingPropertyDescriptor {
    id: customSecondaryFXOverlayBlockProp
    path: "mapping.settings.custom_secondary_fx_overlay_block"
    type: MappingPropertyDescriptor.Boolean
    value: false
    onValueChanged: {
      if (fx_section.layer == FXSectionLayer.fx_secondary) {
        fx_section.layer = FXSectionLayer.fx_primary
      }
    }
  }


  // AppProperty used as toggles and modifier conditions instead of their original functions. Decks A and B cannot be used as Remix Decks when these properties are used.
  AppProperty { id: remixPageDeckA; path: "app.traktor.decks.1.remix.page"; }
  AppProperty { id: remixPageDeckB; path: "app.traktor.decks.2.remix.page"; }
  AppProperty { id: alternateEncoderSetupToggleProp; path: "app.traktor.decks.2.remix.players.4.sequencer.steps.14"; }
  // AppProperty { id: cueBlinkerToggleProp; path: "app.traktor.decks.2.remix.players." + module.deckIdx + ".sequencer.steps.15"; }
  // AppProperty { id: playBlinkerToggleProp; path: "app.traktor.decks.2.remix.players." + module.deckIdx + ".sequencer.steps.16"; }
  
  // ...
  
  AppProperty { id: clockBPMProp; path: "app.traktor.masterclock.tempo" }
  MappingPropertyDescriptor {
    id: masterClockTempoMultiplierProp
    path: "mapping.settings.master_clock_blink_multiplier"
    type: MappingPropertyDescriptor.Float
    value: 1.0 // (120 / clockBPMProp.value)
  }

  // AppProperty {
    // id: cueMonitorChannelProp1;
    // path: "app.traktor.mixer.channels.1.cue";
    // onValueChanged: {
      // if (value && customSingleCueMonitorProp.value) {
        // cueMonitorChannelProp2.value = false;
        // cueMonitorChannelProp3.value = false;
        // cueMonitorChannelProp4.value = false;
      // }
    // }
  // }
  // AppProperty {
    // id: cueMonitorChannelProp2;
    // path: "app.traktor.mixer.channels.2.cue";
    // onValueChanged: {
      // if (value && customSingleCueMonitorProp.value) {
        // cueMonitorChannelProp1.value = false;
        // cueMonitorChannelProp3.value = false;
        // cueMonitorChannelProp4.value = false;
      // }
    // }
  // }
  // AppProperty {
    // id: cueMonitorChannelProp3;
    // path: "app.traktor.mixer.channels.3.cue";
    // onValueChanged: {
      // if (value && customSingleCueMonitorProp.value) {
        // cueMonitorChannelProp1.value = false;
        // cueMonitorChannelProp2.value = false;
        // cueMonitorChannelProp4.value = false;
      // }
    // }
  // }
  // AppProperty {
    // id: cueMonitorChannelProp4;
    // path: "app.traktor.mixer.channels.4.cue";
    // onValueChanged: {
      // if (value && customSingleCueMonitorProp.value) {
        // cueMonitorChannelProp1.value = false;
        // cueMonitorChannelProp2.value = false;
        // cueMonitorChannelProp3.value = false;
      // }
    // }
  // }

  MappingPropertyDescriptor { id: customFxUnitDryWetStored1; path: "mapping.settings.custom_fx_unit_dry_wet_stored_1"; type: MappingPropertyDescriptor.Float; value: 0.5 }
  MappingPropertyDescriptor { id: customFxUnitDryWetStored2; path: "mapping.settings.custom_fx_unit_dry_wet_stored_2"; type: MappingPropertyDescriptor.Float; value: 0.5 }
  MappingPropertyDescriptor { id: customFxUnitDryWetStored3; path: "mapping.settings.custom_fx_unit_dry_wet_stored_3"; type: MappingPropertyDescriptor.Float; value: 0.5 }
  MappingPropertyDescriptor { id: customFxUnitDryWetStored4; path: "mapping.settings.custom_fx_unit_dry_wet_stored_4"; type: MappingPropertyDescriptor.Float; value: 0.5 }
  
  AppProperty { id: fxUnit1Store; path: "app.traktor.fx.1.store"; onValueChanged: if (fxUnit1Type.value == FxType.Group) customFxUnitDryWetStored1.value = fxUnit1DryWet.value }
  AppProperty { id: fxUnit2Store; path: "app.traktor.fx.2.store"; onValueChanged: if (fxUnit2Type.value == FxType.Group) customFxUnitDryWetStored2.value = fxUnit2DryWet.value }
  AppProperty { id: fxUnit3Store; path: "app.traktor.fx.3.store"; onValueChanged: if (fxUnit3Type.value == FxType.Group) customFxUnitDryWetStored3.value = fxUnit3DryWet.value }
  AppProperty { id: fxUnit4Store; path: "app.traktor.fx.4.store"; onValueChanged: if (fxUnit4Type.value == FxType.Group) customFxUnitDryWetStored4.value = fxUnit4DryWet.value }

  AppProperty { id: fxUnit1Type; path: "app.traktor.fx.1.type"; onValueChanged: if (value == FxType.Group) fxUnit1DryWet.value = customFxUnitDryWetStored1.value }
  AppProperty { id: fxUnit2Type; path: "app.traktor.fx.2.type"; onValueChanged: if (value == FxType.Group) fxUnit2DryWet.value = customFxUnitDryWetStored2.value }
  AppProperty { id: fxUnit3Type; path: "app.traktor.fx.3.type"; onValueChanged: if (value == FxType.Group) fxUnit3DryWet.value = customFxUnitDryWetStored3.value }
  AppProperty { id: fxUnit4Type; path: "app.traktor.fx.4.type"; onValueChanged: if (value == FxType.Group) fxUnit4DryWet.value = customFxUnitDryWetStored4.value }
  
  AppProperty { id: fxUnit1DryWet; path: "app.traktor.fx.1.dry_wet"; onValueChanged: if (fxUnit1Type.value == FxType.Group) customFxUnitDryWetStored1.value = fxUnit1DryWet.value }
  AppProperty { id: fxUnit2DryWet; path: "app.traktor.fx.2.dry_wet"; onValueChanged: if (fxUnit2Type.value == FxType.Group) customFxUnitDryWetStored2.value = fxUnit2DryWet.value }
  AppProperty { id: fxUnit3DryWet; path: "app.traktor.fx.3.dry_wet"; onValueChanged: if (fxUnit3Type.value == FxType.Group) customFxUnitDryWetStored3.value = fxUnit3DryWet.value }
  AppProperty { id: fxUnit4DryWet; path: "app.traktor.fx.4.dry_wet"; onValueChanged: if (fxUnit4Type.value == FxType.Group) customFxUnitDryWetStored4.value = fxUnit4DryWet.value }
  
  AppProperty { id: fxMode; path: "app.traktor.fx.4fx_units"; onValueChanged: fxModeChanged() }

  function fxModeChanged() {
    if (fxMode.value == FxMode.TwoFxUnits) {
      fxAssignmentProp.value = DeviceAssignment.fx_1_2
      if (fx_section.layer == FXSectionLayer.fx_secondary) {
        fx_section.layer = FXSectionLayer.fx_primary
      }
    }
    else if (customLinkFXOverlayToDeckProp.value) {
      fxAssignmentProp.value = deckAssignmentProp.value
    }
  }
  
  // Settings
  MappingPropertyDescriptor { path: "mapping.settings.nudge_push_size"; type: MappingPropertyDescriptor.Integer; value: 11 /* 32 beats */ }
  MappingPropertyDescriptor { path: "mapping.settings.nudge_shiftpush_size"; type: MappingPropertyDescriptor.Integer; value: 11 /* 32 beats */ }
  MappingPropertyDescriptor { id: nudgePushActionProp; path: "mapping.settings.nudge_push_action"; type: MappingPropertyDescriptor.Integer; value: 0 /* Tempo Bend */ }
  MappingPropertyDescriptor { id: nudgeShiftPushActionProp; path: "mapping.settings.nudge_shiftpush_action"; type: MappingPropertyDescriptor.Integer; value: 1 /* Beatjump */ }
  
  MappingPropertyDescriptor { id: hotcue12PushActionProp; path: "mapping.settings.hotcue12_push_action"; type: MappingPropertyDescriptor.Integer; value: 0 /* Hotcues 1-2 */ }
  MappingPropertyDescriptor { id: hotcue34PushActionProp; path: "mapping.settings.hotcue34_push_action"; type: MappingPropertyDescriptor.Integer; value: 1 /* Hotcues 3-4 */ }
  MappingPropertyDescriptor { id: hotcue12ShiftPushActionProp; path: "mapping.settings.hotcue12_shiftpush_action"; type: MappingPropertyDescriptor.Integer; value: 4 /* Delete Hotcues 1-2 */ }
  MappingPropertyDescriptor { id: hotcue34ShiftPushActionProp; path: "mapping.settings.hotcue34_shiftpush_action"; type: MappingPropertyDescriptor.Integer; value: 5 /* Delete Hotcues 3-4 */ }

  MappingPropertyDescriptor { id: browseShiftActionProp; path: "mapping.settings.browse_shift_action"; type: MappingPropertyDescriptor.Integer; value: 0 /* Tree Up/Down */ }
  MappingPropertyDescriptor { id: browseShiftPushActionProp; path: "mapping.settings.browse_shiftpush_action"; type: MappingPropertyDescriptor.Integer; value: 0 /* Expand/Collapse tree folders */ }

  MappingPropertyDescriptor { id: loopShiftActionProp; path: "mapping.settings.loop_shift_action"; type: MappingPropertyDescriptor.Integer; value: 0 /* Beatjump Loop */ }

  // MappingPropertyDescriptor { id: maximizeBrowserWhenBrowsingProp; path: "mapping.settings.maximize_browser_when_browsing"; type: MappingPropertyDescriptor.Boolean; value: false }

  // MappingPropertyDescriptor { path: "mapping.settings.deck_display.main_info"; type: MappingPropertyDescriptor.Integer; value: 0 /* Remaining Time */ }

  // Color override
  MappingPropertyDescriptor { path: "mapping.settings.12_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.hotcues.1.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.12_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.hotcues.2.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.12_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.hotcues.1.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.12_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.hotcues.2.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.12_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.34_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.hotcues.3.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.34_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.hotcues.4.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.34_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.hotcues.3.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.34_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.hotcues.4.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.34_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.nudge_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.nudge_slow.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.nudge_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.nudge_fast.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.nudge_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.nudge_slow.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.nudge_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.nudge_fast.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.nudge_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.cue_rev_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.cue.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.cue_rev_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.rev.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.cue_rev_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.cue.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.cue_rev_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.rev.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.cue_rev_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.play_button.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.play.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.play_button.custom_color"; input: false } }
  Wire { from: "surface.right.play.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.play_button.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.sync_button.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.sync.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.sync_button.custom_color"; input: false } }
  Wire { from: "surface.right.sync.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.sync_button.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.fx_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.fx.buttons.1.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.fx.buttons.2.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.fx.buttons.3.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.fx.buttons.4.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.fx.buttons.1.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.fx.buttons.2.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.fx.buttons.3.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.fx.buttons.4.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.fx_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { path: "mapping.settings.assign_buttons.custom_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }
  Wire { from: "surface.left.assign.left.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.assign_buttons.custom_color"; input: false } }
  Wire { from: "surface.left.assign.right.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.assign_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.assign.left.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.assign_buttons.custom_color"; input: false } }
  Wire { from: "surface.right.assign.right.custom_color"; to: DirectPropertyAdapter { path: "mapping.settings.assign_buttons.custom_color"; input: false } }

  MappingPropertyDescriptor { id: showEndWarningProp; path: "mapping.settings.bottom_leds.show_end_warning"; type: MappingPropertyDescriptor.Boolean; value: true }
  MappingPropertyDescriptor { id: showSyncWarningProp; path: "mapping.settings.bottom_leds.show_sync_warning"; type: MappingPropertyDescriptor.Boolean; value: true }
  MappingPropertyDescriptor { id: showActiveLoopProp; path: "mapping.settings.bottom_leds.show_active_loop"; type: MappingPropertyDescriptor.Boolean; value: true }
  MappingPropertyDescriptor { id: bottomLedsDefaultColorProp; path: "mapping.settings.bottom_leds.default_color"; type: MappingPropertyDescriptor.Integer; value: Color.Black }

  MappingPropertyDescriptor { id: leftDeckIdxProp; path: "mapping.settings.left_deck_index"; type: MappingPropertyDescriptor.Integer; value: deviceSetup.leftDeckIdx }
  MappingPropertyDescriptor { id: rightDeckIdxProp; path: "mapping.settings.right_deck_index"; type: MappingPropertyDescriptor.Integer; value: deviceSetup.rightDeckIdx }

  // DUPLICATE DECK
  MappingPropertyDescriptor { 
    id: duplicateDeckSourceIDProp; 
    path: "mapping.state.duplicate_deck_source_id"; 
    type: MappingPropertyDescriptor.Integer
    value: 0
    min: 0
    max: 4
  }

  AppProperty { id: deckTypeProp1; path: "app.traktor.decks.1.type"; }
  AppProperty { id: deckTypeProp2; path: "app.traktor.decks.2.type"; }
  AppProperty { id: deckTypeProp3; path: "app.traktor.decks.3.type"; }
  AppProperty { id: deckTypeProp4; path: "app.traktor.decks.4.type"; }

  AppProperty { id: deckIsPlayingProp1; path: "app.traktor.decks.1.play"; }
  AppProperty { id: deckIsPlayingProp2; path: "app.traktor.decks.2.play"; }
  AppProperty { id: deckIsPlayingProp3; path: "app.traktor.decks.3.play"; }
  AppProperty { id: deckIsPlayingProp4; path: "app.traktor.decks.4.play"; }

  AppProperty { id: deckIsLoaded1; path: "app.traktor.decks.1.is_loaded"; }
  AppProperty { id: deckIsLoaded2; path: "app.traktor.decks.2.is_loaded"; }
  AppProperty { id: deckIsLoaded3; path: "app.traktor.decks.3.is_loaded"; }
  AppProperty { id: deckIsLoaded4; path: "app.traktor.decks.4.is_loaded"; }

  AppProperty { id: duplicateToDeck1FromDeck2; path: "app.traktor.decks.1.track.duplicate_deck.2"; }
  AppProperty { id: duplicateToDeck1FromDeck3; path: "app.traktor.decks.1.track.duplicate_deck.3"; }
  AppProperty { id: duplicateToDeck1FromDeck4; path: "app.traktor.decks.1.track.duplicate_deck.4"; }

  AppProperty { id: duplicateToDeck2FromDeck1; path: "app.traktor.decks.2.track.duplicate_deck.1"; }
  AppProperty { id: duplicateToDeck2FromDeck3; path: "app.traktor.decks.2.track.duplicate_deck.3"; }
  AppProperty { id: duplicateToDeck2FromDeck4; path: "app.traktor.decks.2.track.duplicate_deck.4"; }

  AppProperty { id: duplicateToDeck3FromDeck1; path: "app.traktor.decks.3.track.duplicate_deck.1"; }
  AppProperty { id: duplicateToDeck3FromDeck2; path: "app.traktor.decks.3.track.duplicate_deck.2"; }
  AppProperty { id: duplicateToDeck3FromDeck4; path: "app.traktor.decks.3.track.duplicate_deck.4"; }

  AppProperty { id: duplicateToDeck4FromDeck1; path: "app.traktor.decks.4.track.duplicate_deck.1"; }
  AppProperty { id: duplicateToDeck4FromDeck2; path: "app.traktor.decks.4.track.duplicate_deck.2"; }
  AppProperty { id: duplicateToDeck4FromDeck3; path: "app.traktor.decks.4.track.duplicate_deck.3"; }
  
  // Shift
  property alias shift: shiftProp
  MappingPropertyDescriptor { id: shiftProp; path: mapping.propertiesPath + ".shift"; type: MappingPropertyDescriptor.Boolean; value: false }
  // Wire { from: "surface.shift";  to: DirectPropertyAdapter { path: mapping.propertiesPath + ".shift"  } }

  Browser { name: "browser" }

  AppProperty { id: previewplayerUnloadProp; path:"app.traktor.browser.preview_player.unload" }
  AppProperty { id: previewplayerPlayProp; path:"app.traktor.browser.preview_player.play" }
  
  Timer {
    id: shiftBlinkTimer
    property bool  blink: false
    interval: 250 * masterClockTempoMultiplierProp.value
    repeat: true
    running: browserModeProp.value
    onTriggered: {
      blink = !blink;
    }
    onRunningChanged: {
      blink = running;
    }
  }

  Wire {
    from: "surface.shift"
    to: ButtonScriptAdapter {
      brightness: shiftProp.value || shiftBlinkTimer.blink ? 1.0 : 0.0; 
      onPress: {
        shiftProp.value = true;
        holdShift_countdown.restart()
      }
      onRelease: {
        shiftProp.value = false;
        // if ( (holdShift_countdown.running) && (deviceSetup.state == DeviceSetupState.assigned) ) {
        if ( (holdShift_countdown.running) && customBrowserModeProp.value && (deviceSetup.state == DeviceSetupState.assigned) ) {
          browserModeProp.value = !browserModeProp.value
          previewplayerPlayProp.value = false
          // previewplayerUnloadProp.value = !previewplayerUnloadProp.value
          // holdShift_countdown.stop()
        }
      }
    }
  }
  
  Timer {
    id: holdShift_countdown;
    interval: 200
    // onTriggered: {
      // if (!browserModeProp.value) previewplayerUnloadProp.value = !previewplayerUnloadProp.value      
      // if (!customBrowserModeProp.value) previewplayerUnloadProp.value = !previewplayerUnloadProp.value      
    // }
  }
    
  WiresGroup {
    // enabled: (deviceSetup.state == DeviceSetupState.assigned) && browserModeProp.value 
    enabled: (deviceSetup.state == DeviceSetupState.assigned) && browserModeProp.value && customBrowserModeProp.value
    
    WiresGroup {
      
      Wire { enabled: !shiftProp.value; from: "surface.left.browse.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; wrap: true; step: 1; mode: RelativeMode.Stepped } }
      Wire { enabled: shiftProp.value; from: "surface.left.browse.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; wrap: true; step: 10; mode: RelativeMode.Stepped } }
      Wire { enabled: !shiftProp.value; from: "surface.right.browse.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; wrap: true; step: 1; mode: RelativeMode.Stepped } }
      Wire { enabled: shiftProp.value; from: "surface.right.browse.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.list.select_up_down"; wrap: true; step: 10; mode: RelativeMode.Stepped } }
      Wire { enabled: !shiftProp.value; from: "surface.right.loop.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.preview_player.seek"; step: 0.05; mode: RelativeMode.Stepped } }
      Wire { enabled: shiftProp.value; from: "surface.right.loop.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.favorites.select"; wrap: true; step: 1; mode: RelativeMode.Stepped } }
        
    }
      
    WiresGroup {
      
      Wire { from: "surface.left.loop"; to: "browser.tree_navigation" }
      Wire { enabled: shiftProp.value; from: "surface.left.loop.turn"; to: RelativePropertyAdapter { path: "app.traktor.browser.tree.select_up_down"; wrap: true; step: 9; mode: RelativeMode.Stepped } }
      Wire { enabled: !shiftProp.value; from: "surface.right.loop.push"; to: TriggerPropertyAdapter { path:"app.traktor.browser.preview_player.load_or_play" } }
      Wire { enabled: shiftProp.value; from: "surface.right.loop.push"; to: TriggerPropertyAdapter { path:"app.traktor.browser.preparation.jump_to_list" } }
        
    }
      
  }

  X1MK3Side
  {
    name: "left_deck"
    surface: "surface.left"
    propertiesPath: mapping.propertiesPath + ".left.deck"
    active: deviceSetup.state == DeviceSetupState.assigned

    shift: shiftProp.value
    deckIdx: deviceSetup.leftDeckIdx

    fxSectionLayer: fxSection.layer
    leftPrimaryFxIdx: deviceSetup.leftPrimaryFxIdx
    rightPrimaryFxIdx: deviceSetup.rightPrimaryFxIdx
    leftSecondaryFxIdx: deviceSetup.leftSecondaryFxIdx
    rightSecondaryFxIdx: deviceSetup.rightSecondaryFxIdx

    fxAssignmentPropertiesPath: mapping.propertiesPath + ".left.fx"
    sidePrimaryFxIdx: deviceSetup.leftPrimaryFxIdx
    sideSecondaryFxIdx: deviceSetup.leftSecondaryFxIdx

    nudgePushAction: nudgePushActionProp.value
    nudgeShiftPushAction: nudgeShiftPushActionProp.value

    hotcue12PushAction: hotcue12PushActionProp.value
    hotcue34PushAction: hotcue34PushActionProp.value
    hotcue12ShiftPushAction: hotcue12ShiftPushActionProp.value
    hotcue34ShiftPushAction: hotcue34ShiftPushActionProp.value

    browseShiftAction: browseShiftActionProp.value
    browseShiftPushAction: browseShiftPushActionProp.value

    loopShiftAction: loopShiftActionProp.value

    showEndWarning: showEndWarningProp.value
    showSyncWarning: showSyncWarningProp.value
    showActiveLoop: showActiveLoopProp.value
    bottomLedsDefaultColor: bottomLedsDefaultColorProp.value
  }

  X1MK3Side
  {
    name: "right_deck"
    surface: "surface.right"
    propertiesPath: mapping.propertiesPath + ".right.deck"
    active: deviceSetup.state == DeviceSetupState.assigned

    shift: shiftProp.value
    deckIdx: deviceSetup.rightDeckIdx

    fxSectionLayer: fxSection.layer
    leftPrimaryFxIdx: deviceSetup.leftPrimaryFxIdx
    rightPrimaryFxIdx: deviceSetup.rightPrimaryFxIdx
    leftSecondaryFxIdx: deviceSetup.leftSecondaryFxIdx
    rightSecondaryFxIdx: deviceSetup.rightSecondaryFxIdx

    fxAssignmentPropertiesPath: mapping.propertiesPath + ".right.fx"
    sidePrimaryFxIdx: deviceSetup.rightPrimaryFxIdx
    sideSecondaryFxIdx: deviceSetup.rightSecondaryFxIdx

    nudgePushAction: nudgePushActionProp.value
    nudgeShiftPushAction: nudgeShiftPushActionProp.value

    hotcue12PushAction: hotcue12PushActionProp.value
    hotcue34PushAction: hotcue34PushActionProp.value
    hotcue12ShiftPushAction: hotcue12ShiftPushActionProp.value
    hotcue34ShiftPushAction: hotcue34ShiftPushActionProp.value

    browseShiftAction: browseShiftActionProp.value
    browseShiftPushAction: browseShiftPushActionProp.value

    loopShiftAction: loopShiftActionProp.value

    showEndWarning: showEndWarningProp.value
    showSyncWarning: showSyncWarningProp.value
    showActiveLoop: showActiveLoopProp.value
    bottomLedsDefaultColor: bottomLedsDefaultColorProp.value
  }

  MappingPropertyDescriptor {
    id: browserModeProp;
    path: "mapping.state.browser_mode";
    type: MappingPropertyDescriptor.Boolean;
    value: false;
    onValueChanged: {
      if (maximizeBrowserWhenBrowsingProp.value && (browserFullScreenProp.value != value)) {
        browserFullScreenProp.value = value
      }
      previewplayerUnloadProp.value = !previewplayerUnloadProp.value
      duplicateDeckSourceIDProp.value = 0
    }
  }
  
  AppProperty { id: browserFullScreenProp; path: "app.traktor.browser.full_screen";
    onValueChanged: {
      // if (maximizeBrowserWhenBrowsingProp.value && (browserModeProp.value != value)) browserModeProp.value = value
      if (maximizeBrowserWhenBrowsingProp.value && customBrowserModeProp.value && (browserModeProp.value != value)) browserModeProp.value = value
      // previewplayerUnloadProp.value = !previewplayerUnloadProp.value
    }
  }

  property bool fullScreenTimerRunning: false

  SwitchTimer {
    name: "show_browser_full_screen_timer";
    setTimeout: 0;
    resetTimeout: 2000;

    onSet: {
      fullScreenTimerRunning = true;
      browserFullScreenProp.value = true;
      // browserModeProp.value = true;
    }

    onReset: {
      fullScreenTimerRunning = false;
      browserFullScreenProp.value = false
      // browserModeProp.value = false
    }
  }

  WiresGroup {
    // enabled: (deviceSetup.state == DeviceSetupState.assigned) && maximizeBrowserWhenBrowsingProp.value
    // enabled: (deviceSetup.state == DeviceSetupState.assigned) && maximizeBrowserWhenBrowsingProp.value && !customBrowserModeProp.value
    enabled: (deviceSetup.state == DeviceSetupState.assigned) && maximizeBrowserWhenBrowsingProp.value && !customBrowserModeProp.value
      && (!alternateEncoderSetupToggleProp.value || (alternateEncoderSetupToggleProp.value && (fxSection.layer == FXSectionLayer.mixer ) ) )

    Wire {
      from: Or
      {
        inputs: [ "surface.left.browse.is_turned", "surface.right.browse.is_turned" ]
      }
      to: "show_browser_full_screen_timer.input"
    }

    Wire {
      enabled: shiftProp.value && browseShiftPushActionProp.value == BrowseEncoderAction.browse_expand_tree;
      from: Or
      {
        inputs: [ "surface.left.browse.push", "surface.right.browse.push" ]
      }
      to: "show_browser_full_screen_timer.input"
    }

    Wire {
      enabled: !shiftProp.value && fullScreenTimerRunning && browserModeProp.value;
      from: Or
      {
        inputs: [ "surface.left.browse.push", "surface.right.browse.push" ]
      }
      to: ValuePropertyAdapter { path: "app.traktor.browser.full_screen"; output: false; ignoreEvents: PinEvent.WireEnabled | PinEvent.WireDisabled }
    }
  }

  X1MK3FXSection
  {
    id: fxSection
    name: "fx_section"
    surface: "surface"
    shift: shiftProp.value
    propertiesPath: mapping.propertiesPath
    active: deviceSetup.state == DeviceSetupState.assigned

    leftDeckIdx: deviceSetup.leftDeckIdx
    rightDeckIdx: deviceSetup.rightDeckIdx

    leftPrimaryFxIdx: deviceSetup.leftPrimaryFxIdx
    rightPrimaryFxIdx: deviceSetup.rightPrimaryFxIdx
    leftSecondaryFxIdx: deviceSetup.leftSecondaryFxIdx
    rightSecondaryFxIdx: deviceSetup.rightSecondaryFxIdx
  }

  // Blinking timer for screens
  MappingPropertyDescriptor { id: blinkerProp; path: mapping.propertiesPath + ".blinker"; type: MappingPropertyDescriptor.Boolean; value: false }
  Timer { interval: 500 * masterClockTempoMultiplierProp.value; running: true; repeat: true; onTriggered: blinkerProp.value = blinkerProp.value ? false : true; }
} //Mapping
