/** Shared type definitions for class/spec/addon data */

export type ClassId =
  | 'warrior' | 'paladin' | 'hunter' | 'rogue'
  | 'priest' | 'shaman' | 'mage' | 'warlock'
  | 'monk' | 'druid' | 'death_knight' | 'demon_hunter';

export interface ClassInfo {
  id: ClassId;
  name: string;
  icon: string; // CSS class or asset path for the class icon
  specs: SpecInfo[];
}

export interface SpecInfo {
  id: string;
  name: string;
  order: number;
}

export type Priority = 'essential' | 'recommended' | 'optional';

export interface AddonRecommendation {
  /** Exact addon display name as shown in Twitch/curseforge */
  name: string;
  /** Internal key used for settings targeting */
  key: string;
  /** Minimum recommended version */
  minVersion?: string;
  /** Priority level */
  priority: Priority;
  /** Short description of what this addon does */
  description: string;
  /** URL to download / install page */
  url?: string;
  /** SavedVariables global name that the addon uses (for auto-configure) */
  savedVariableName?: string;
  /** Default settings overrides to apply */
  defaultSettings: Record<string, unknown>;
}

export interface ClassSpecKey {
  classId: ClassId;
  specId: string;
  toString(): string;
}

/** A user profile: which addons they want for a given class/spec combo */
export interface UserProfile {
  id: string;
  name: string;
  classId: ClassId;
  specId: string;
  selectedAddons: string[]; // addon keys the user has chosen to apply
  customOverrides?: Record<string, Record<string, unknown>>; // per-addon settings overrides
  createdAt: number;
  updatedAt: number;
}
