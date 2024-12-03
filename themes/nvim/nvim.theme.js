import fs from 'fs';
import path from 'path';
import { exec } from 'child_process';

/**
 * Function to update Neovim theme
 * @param {string} theme
 * @param {(theme: string, source: string, targetPath: string, config?: string, callback?: () => void)=> void} setThemeCallback
 * @returns {void}
 */
export function setNvimTheme(theme, setThemeCallback) {
    try {
        const target =
            path.join(
                process.env.HOME,
                'development',
                'dotfiles',
                'config',
                'nvim',
                'lua',
                'plugins',
            ) + '/colorscheme.lua';
        const nvimThemesDir = path.join(
            process.env.HOME,
            'development',
            'dotfiles',
            'themes',
            'nvim',
        );
        const source = `${nvimThemesDir}/${theme}.lua`;
        const cb = () => {
            const servers = getServers();
            for (const server of servers) {
                exec(
                    `nvim --server /tmp/${server} --remote-send ":colorscheme ${theme}<CR>"`,
                );
            }
        };
        setThemeCallback(theme, source, target, 'Neovim', cb);
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}

const getServers = () => {
    const dir = '/tmp';
    const files = fs.readdirSync(dir);
    const servers = [];
    for (const file of files) {
        if (file.startsWith('nvim-')) {
            servers.push(file);
        }
    }
    if (servers.length) console.log(`Live nvim servers: ${servers.length}`, servers);
    return servers;
}
