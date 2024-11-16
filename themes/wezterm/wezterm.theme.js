import path from 'path';

/**
 * Function to update Wezterm theme
 * @param {string} theme
 * @param {(theme: string, source: string, targetPath: string, config?: string, callback?: () => void)=> void} setThemeCallback
 * @returns {void}
 */
export function setWeztermTheme(theme, setThemeCallback) {
    const target =
        path.join(process.env.HOME, 'development', 'dotfiles') +
        '/wezterm-theme.lua';
    const wezterFilePath =
        path.join(process.env.HOME, 'development', 'dotfiles') + '/wezterm.lua';
    const weztermThemesDir = path.join(
        process.env.HOME,
        'development',
        'dotfiles',
        'themes',
        'wezterm',
    );
    const source = `${weztermThemesDir}/${theme}.lua`;
    setThemeCallback(theme, source, target);
    setThemeCallback(theme, wezterFilePath, wezterFilePath, 'Wezterm');
}
