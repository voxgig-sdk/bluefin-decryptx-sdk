// Typed models for the BluefinDecryptx SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Decrypt {
  client_id?: string
  code?: number
  decrypted?: any[]
  decryption_parameter: Record<string, any>
  encrypted: any[]
  failed?: boolean
  firmware?: string
  has_cc_data: boolean
  message?: string
  message_id: string
  name: string
  partner_id?: string
  partner_key?: string
  reference: string
  serial: string
  success: boolean
  value?: string
}

export interface DecryptListMatch {
  client_id?: string
  code?: number
  decrypted?: any[]
  decryption_parameter?: Record<string, any>
  encrypted?: any[]
  failed?: boolean
  firmware?: string
  has_cc_data?: boolean
  message?: string
  message_id?: string
  name?: string
  partner_id?: string
  partner_key?: string
  reference?: string
  serial?: string
  success?: boolean
  value?: string
}

export interface DecryptCreateData {
  client_id?: string
  code?: number
  decrypted?: any[]
  decryption_parameter: Record<string, any>
  encrypted: any[]
  failed?: boolean
  firmware?: string
  has_cc_data: boolean
  message?: string
  message_id: string
  name: string
  partner_id?: string
  partner_key?: string
  reference: string
  serial: string
  success: boolean
  value?: string
}

export interface DecryptExt {
  client_id?: string
  completed?: string
  decrypted?: number
  encrypted: number
  ip?: string
  message_id?: string
  partner_id: string
  partner_key?: string
  reference?: string
  serial: string
  success?: boolean
}

export interface DecryptExtCreateData {
  client_id?: string
  completed?: string
  decrypted?: number
  encrypted: number
  ip?: string
  message_id?: string
  partner_id: string
  partner_key?: string
  reference?: string
  serial: string
  success?: boolean
}

export interface Validation {
  client_id?: string
  firmware?: string
  message_id: string
  partner_id?: string
  partner_key?: string
  reference: string
  serial: string
  success: boolean
}

export interface ValidationCreateData {
  client_id?: string
  firmware?: string
  message_id: string
  partner_id?: string
  partner_key?: string
  reference: string
  serial: string
  success: boolean
}

