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
        console.log('inside setNvimTheme function')
        const target = path.join(process.env.HOME, 'development', 'dotfiles', 'config', 'nvim', 'lua', 'plugins') + '/colorscheme.lua';
        const nvimThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'nvim');
        const source = `${nvimThemesDir}/${theme}.lua`;
        const cb = () => {
            exec(`nvim --server /tmp/nvim.sock --remote-send ":colorscheme ${theme}<CR>"`)
        };
        setThemeCallback(theme, source, target, 'Neovim', cb);
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}

