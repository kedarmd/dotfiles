import path from 'path';

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
