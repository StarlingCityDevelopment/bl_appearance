<script lang="ts">
    import { createEventDispatcher, onMount } from 'svelte';

    const dispatch = createEventDispatcher<{
        change: { x: number; y: number; displayX: number; displayY: number };
    }>();

    export let x = 1;
    export let y = 1;
    export let min = -1;
    export let max = 1;
    export let step = 0.01;
    export let width_locale = 'width';
    export let height_locale = 'height';

    let container: HTMLDivElement;
    let displayValueX = 0;
    let displayValueY = 0;
    let isDragging = false;

    const range = max - min;
    const stepMultiplier = 1 / step;

    function applyStep(value: number): number {
        return Math.round(value * stepMultiplier) / stepMultiplier;
    }

    function actualToNormalized(actual: number): number {
        return (actual - min) / range;
    }

    function normalizedToActual(normalized: number): number {
        return min + normalized * range;
    }

    function updatePosition(clientX: number, clientY: number): void {
        if (!isDragging || !container) return;

        const rect = container.getBoundingClientRect();
        const normalizedX = Math.max(
            0,
            Math.min(1, (clientX - rect.left) / rect.width),
        );
        const normalizedY = Math.max(
            0,
            Math.min(1, 1 - (clientY - rect.top) / rect.height),
        );

        const actualX = Math.max(
            min,
            Math.min(max, applyStep(normalizedToActual(normalizedX))),
        );
        const actualY = Math.max(
            min,
            Math.min(max, applyStep(normalizedToActual(1 - normalizedY))),
        );

        x = actualX;
        y = actualY;
        
        displayValueX = actualToNormalized(actualX);
        displayValueY = 1 - actualToNormalized(actualY);

        dispatch('change', {
            x: actualX,
            y: actualY,
            displayX: displayValueX,
            displayY: displayValueY,
        });
    }

    function handlePointerStart(e: MouseEvent | TouchEvent): void {
        e.preventDefault();
        isDragging = true;

        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        const clientY = 'touches' in e ? e.touches[0].clientY : e.clientY;

        updatePosition(clientX, clientY);
    }

    function handlePointerMove(e: MouseEvent | TouchEvent): void {
        if (!isDragging) return;

        const clientX = 'touches' in e ? e.touches[0].clientX : e.clientX;
        const clientY = 'touches' in e ? e.touches[0].clientY : e.clientY;

        updatePosition(clientX, clientY);
    }

    function stopDragging(): void {
        isDragging = false;
    }

    onMount(() => {
        displayValueX = actualToNormalized(x);
        displayValueY = 1 - actualToNormalized(y);
    });
</script>

<svelte:window
    on:mousemove={handlePointerMove}
    on:mouseup={stopDragging}
    on:touchmove={handlePointerMove}
    on:touchend={stopDragging}
/>

<div
    class="wrapper w-[95%] rounded-lg mb-[1vh]"
    style="--value-x: {displayValueX}; --value-y: {displayValueY};"
>
    <div
        role="none"
        class="container w-full h-[150px] rounded-lg"
        on:mousedown={handlePointerStart}
        on:touchstart={handlePointerStart}
        bind:this={container}
    >
        <div
            class="point"
            style="left: {displayValueX * 100}%; top: {(1 - displayValueY) * 100}%"
        />
        <p class="x-axis-label">{width_locale}</p>
        <p class="y-axis-label">{height_locale}</p>
    </div>
    <div class="w-full flex items-center justify-center gap-4 mt-4">
        <div class="progress-x rounded-lg w-1/2 h-1.5"></div>
        <div class="progress-y rounded-lg w-1/2 h-1.5"></div>
    </div>
</div>

<style>
    .container {
        border: 0.2vh solid rgb(255, 0, 0);
        position: relative;
        user-select: none;
        touch-action: none;
        background: rgb(0 0 0 / 0.5) url('./images/arrows_background.png');
        background-size: 100% 100%;
    }

    .point {
        width: 20px;
        height: 20px;
        background: white;
        border-radius: 50%;
        position: absolute;
        transform: translate(-50%, -50%);
        cursor: grab;
        box-shadow: 0 0 3px rgba(0, 0, 0, 0.3);
        z-index: 1;
    }

    .point:active {
        cursor: grabbing;
    }

    .x-axis-label {
        position: absolute;
        font-size: 12px;
        right: 10px;
        bottom: 50%;
    }

    .y-axis-label {
        position: absolute;
        font-size: 12px;
        top: 3px;
        right: 0;
        width: 49%;
        text-align: start;
    }

    .progress-x {
        background: linear-gradient(
            to right,
            var(--accent) calc(var(--value-x) * 100%),
            rgb(0 0 0 / 0.5) calc(var(--value-x) * 100%)
        );
    }

    .progress-y {
        background: linear-gradient(
            to right,
            var(--accent) calc(var(--value-y) * 100%),
            rgb(0 0 0 / 0.5) calc(var(--value-y) * 100%)
        );
    }
</style>
