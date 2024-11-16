import path from 'path';

/**
 * Function to update Startship theme
 * @param {string} theme
 * @param {(theme: string, source: string, targetPath: string, config?: string, callback?: () => void)=> void} setThemeCallback
 * @returns {void} 
*/
export function setStarshipTheme(theme, setThemeCallback) {
    try {
        const target = path.join(process.env.HOME, 'development', 'dotfiles', 'config') + '/starship.toml';
        const starshipThemesDir = path.join(process.env.HOME, 'development', 'dotfiles', 'themes', 'starship');
        const source = `${starshipThemesDir}/${theme}.toml`;
        setThemeCallback(theme, source, target, 'Starship');
    } catch (error) {
        console.error(`Failed to set Neovim theme: ${error.message}`);
    }
}
