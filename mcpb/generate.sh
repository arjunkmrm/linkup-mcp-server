#!/bin/bash

set -e

echo "📦 Building Linkup MCP Server MCPB Bundle"
echo ""

echo "Installing MCPB CLI..."
npm install -g @anthropic-ai/mcpb

echo "Building MCP server..."
npm run build:stdio

echo "Validating MCPB manifest..."
# Validate the manifest that Smithery generated
mcpb validate dist/bundle/mcpb-manifest.json

echo "Packing MCPB bundle..."
# Pack from dist/bundle directory (contains index.cjs and mcpb-manifest.json)
# Copy .mcpbignore to exclude unnecessary files
cp mcpb/.mcpbignore dist/bundle/.mcpbignore
# Copy mcpb-manifest.json to manifest.json for packing
cp dist/bundle/mcpb-manifest.json dist/bundle/manifest.json
mcpb pack dist/bundle mcpb/linkup-mcp-server.mcpb

echo "Cleaning up temporary files..."
rm dist/bundle/manifest.json
rm dist/bundle/.mcpbignore

echo ""
echo "✅ MCPB bundle created: mcpb/linkup-mcp-server.mcpb"
