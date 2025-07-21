<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    const dispatch = createEventDispatcher();

    // Component props
    export let width: string = '98%';
    export let height: string = '98%';
    export let scale: string = '1';
    export let active: boolean = false;
    export let disabled: boolean = false;
    export let strokeWidth: string = '0.3vh';
    export let variant: 'accent' | 'success' | 'error' = 'accent';

    // CSS variable for the variant - overridden to red
    let cssVar = 'red';

    // Tailwind classes for fill colors - red when active
    const fills = {
        accent: 'fill-[#FF0000]/75',
        success: 'fill-[#7FEB9D]/75',
        error: 'fill-[#E5283E]/75',
    };

    const transparentFills = {
        accent: 'fill-black/75',
        success: 'fill-[#7FEB9D]/75',
        error: 'fill-[#E5283E]/75',
    };

    // Reactive statements
    $: fill = fills[variant];
    $: transparentFill = transparentFills[variant];
</script>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<!-- svelte-ignore a11y-click-events-have-key-events -->
<svg
    {width}
    {height}
    version="1.1"
    style="transform: scale({scale});"
    class="origin-center transition-all duration-200 {active
        ? fill
        : transparentFill}"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    viewBox="0 0 184.751 184.751"
    xml:space="preserve"
    on:click={() => dispatch('click')}
>
    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"
    ></g>
    <g id="SVGRepo_iconCarrier">
        <path
            stroke={variant === 'accent' ? cssVar : 'black'}
            stroke-width={'0.3vh'}
            d="M0,92.375l46.188-80h92.378l46.185,80l-46.185,80H46.188L0,92.375z"
        />
    </g>
</svg>
