// Hey Emacs, this is -*- coding: utf-8 -*-

/* eslint-disable camelcase */

import type { JTDSchemaType } from 'ajv/dist/jtd';

/// /b/; Common
/// /b/{

export type Role = string;
export type Roles = Role[];
export type Scope = string[];

export const scopeJtd: JTDSchemaType<Scope> = {
  elements: { type: 'string' },
};

export const toScopeArray = (scopeString: string | undefined): string[] => {
  if (typeof scopeString === 'string') {
    const trimmed = scopeString.trim();
    if (!trimmed) {
      return [];
    }
    return trimmed.split(/\s+/);
  }
  return [];
};

export const toScopeString = (scopeArray: string[]): string => {
  return scopeArray.join(' ');
};

export const arraysEqual = (
  lhsArray: string[],
  rhsArray: string[],
): boolean => {
  return (
    lhsArray.length === rhsArray.length &&
    lhsArray.every((value, index) => value === rhsArray[index])
  );
};

// NumericDate as in JWT spec
export type NumericDate = number;

/// /b/}

/// /b/; Authorise Request and URL Query
/// /b/{

export interface AuthoriseQuery {
  response_type: string;
  client_id: string;
  redirect_uri: string;
  state: string;
  scope?: string;
}

export const authoriseQueryJtd: JTDSchemaType<AuthoriseQuery> = {
  properties: {
    response_type: { type: 'string' },
    client_id: { type: 'string' },
    redirect_uri: { type: 'string' },
    state: { type: 'string' },
  },
  optionalProperties: {
    scope: { type: 'string' },
  },
};

export const authoriseQueryToSearchParams = (
  query: AuthoriseQuery,
  params: URLSearchParams,
): void => {
  params.append('response_type', query.response_type);
  params.append('client_id', query.client_id);
  params.append('redirect_uri', query.redirect_uri);
  params.append('state', query.state);
  if (query.scope !== undefined) {
    params.append('scope', query.scope);
  }
};

export type State = AuthoriseQuery['state'];

export interface AuthoriseRequest {
  responseType: string;
  clientId: string;
  redirectUrl: string;
  queryState: string;
  requestedScope: Scope;
}

export const authoriseRequestJtd: JTDSchemaType<AuthoriseRequest> = {
  properties: {
    responseType: { type: 'string' },
    clientId: { type: 'string' },
    redirectUrl: { type: 'string' },
    queryState: { type: 'string' },
    requestedScope: scopeJtd,
  },
};

/// /b/}

/// /b/; Authorise Callback Request and URL Query
/// /b/{

export interface AuthoriseCallbackRequestValue {
  type: 'value';
  state: string;
  code: string;
}

export interface AuthoriseCallbackRequestError {
  type: 'error';
  state: string;
  error: string;
}

export type AuthoriseCallbackRequest =
  | AuthoriseCallbackRequestValue
  | AuthoriseCallbackRequestError;

// eslint-disable-next-line max-len
export const authoriseCallbackRequestJdt: JTDSchemaType<AuthoriseCallbackRequest> =
  {
    discriminator: 'type',
    mapping: {
      value: {
        properties: {
          state: { type: 'string' },
          code: { type: 'string' },
        },
      },
      error: {
        properties: {
          state: { type: 'string' },
          error: { type: 'string' },
        },
      },
    },
  };

export const authoriseCallbackRequestToSearchParams = (
  request: AuthoriseCallbackRequest,
  params: URLSearchParams,
): void => {
  if (request.type === 'error') {
    params.append('type', 'error');
    params.append('state', request.state);
    params.append('error', request.error);
  } else {
    params.append('type', 'value');
    params.append('state', request.state);
    params.append('code', request.code);
  }
};

/// /b/}
