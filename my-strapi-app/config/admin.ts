export default ({ env }) => ({
  auth: {
    // Prefer ADMIN_JWT_SECRET, fallback to STRAPI_ADMIN_SECRET
    secret: env('JWT_SECRET', env('STRAPI_ADMIN_SECRET')),
  },
  apiToken: {
    // Salt for API token generation
    salt: env('API_TOKEN_SALT'),
  },
  transfer: {
    token: {
      // Salt for data transfer token
      salt: env('TRANSFER_TOKEN_SALT', 'defaultTransferSalt'), // Optional fallback
    },
  },
  flags: {
    // Feature flags
    nps: env.bool('FLAG_NPS', true),
    promoteEE: env.bool('FLAG_PROMOTE_EE', true),
  },
});
