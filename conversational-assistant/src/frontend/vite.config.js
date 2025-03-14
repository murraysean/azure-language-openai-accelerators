// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  define: {
    '__CHAT_SERVER_ENDPOINT__': JSON.stringify(process.env.CHAT_SERVER_ENDPOINT)
  }
})
