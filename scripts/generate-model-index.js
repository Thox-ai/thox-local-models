#!/usr/bin/env node

/**
 * Generate THOX Local Models Index
 * Reads all JSON files from manifests/, validates required fields,
 * and writes index/models.json.
 */

import { readFileSync, writeFileSync, readdirSync } from 'fs';
import { join } from 'path';

const REPO_ROOT = process.cwd();
const MANIFESTS_DIR = join(REPO_ROOT, 'manifests');

function readJsonFile(filepath) {
    try {
        const content = readFileSync(filepath, 'utf8');
        return JSON.parse(content);
    } catch (err) {
        console.error(`Error reading ${filepath}: ${err.message}`);
        throw err;
    }
}

function validateManifest(data, filepath) {
    const required = ['id', 'display_name', 'family', 'role', 'upstream', 'capabilities', 'runtime', 'generation', 'thox'];
    for (const field of required) {
        if (!(field in data)) {
            console.error(`Missing required field "${field}" in ${filepath}`);
            return false;
        }
    }

    const upstream = data.upstream;
    const requiredUpstream = ['repo', 'url'];
    for (const field of requiredUpstream) {
        if (!(field in upstream)) {
            console.error(`Missing required upstream field "${field}" in ${filepath}`);
            return false;
        }
    }
    return true;
}

function extractIndexEntry(data) {
    return {
        id: data.id,
        display_name: data.display_name,
        role: data.role,
        upstream_repo: data.upstream.repo,
        upstream_url: data.upstream.url,
        default_for_usb: data.thox.default_for_usb,
        offline_ready: data.thox.offline_ready
    };
}

function main() {
    console.log('Reading manifest files from:', MANIFESTS_DIR);

    const files = readdirSync(MANIFESTS_DIR).filter(f => f.endsWith('.json'));
    if (files.length === 0) {
        console.error('No JSON files found in manifests/');
        process.exit(1);
    }

    const models = [];
    for (const file of files) {
        const manifest = readJsonFile(join(MANIFESTS_DIR, file));
        if (!validateManifest(manifest, file)) {
            process.exit(1);
        }
        models.push(manifest);
        console.log(`Processed: ${file}`);
    }

    // Sort: default_for_usb true first, then by display_name ascending
    models.sort((a, b) => {
        if (a.thox.default_for_usb !== b.thox.default_for_usb) {
            return a.thox.default_for_usb ? -1 : 1;
        }
        return a.display_name.localeCompare(b.display_name);
    });

    const index = {
        generated_at: new Date().toISOString(),
        model_count: models.length,
        models: models.map(extractIndexEntry)
    };

    const outputPath = join(REPO_ROOT, 'index', 'models.json');
    writeFileSync(outputPath, JSON.stringify(index, null, 2), 'utf8');

    console.log(`Wrote index: ${outputPath}`);
    console.log(JSON.stringify(index, null, 2));
}

main();
