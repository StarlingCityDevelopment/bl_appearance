<script lang="ts">
    import ColourDropdown from '@components/micro/ColourDropdown.svelte';
    import NumberStepper from '@components/micro/NumberStepper.svelte';
    import Slider from '@components/micro/Slider.svelte';
    import Wrapper from '@components/micro/Wrapper.svelte';
    import { APPEARANCE, LOCALE } from '@stores/appearance';
    import type { TValue, THeadOverlay } from '@typings/apperance';
    import Percentage from '@components/micro/Percentage.svelte';

    $: data = $APPEARANCE.headStructure;
    let eyeColor = ($APPEARANCE.headOverlay?.EyeColor as TValue) || null;
    $: headOverlay = $APPEARANCE.headOverlay as THeadOverlay;
    $: headOverlayTotal = $APPEARANCE.headOverlayTotal;
</script>

{#if !data}
    <Wrapper label={$LOCALE.NO_FACEMENU} />
{:else}
    {#if data.Nose_Width}
        <Wrapper label={$LOCALE.NOSE_TITLE}>
            <svelte:fragment slot="primary">
                <Percentage
                    bind:x={data.Nose_Width.value}
                    bind:y={data.Nose_Peak_Height.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    bind:width_locale={$LOCALE.WIDTH_SUBTITLE}
                    bind:height_locale={$LOCALE.PEAKHEIGHT_SUBTITLE}
                    on:change={() => {
                        APPEARANCE.setHeadStructure(data.Nose_Width);
                        APPEARANCE.setHeadStructure(data.Nose_Peak_Height);
                    }}
                />
            </svelte:fragment>
            <svelte:fragment slot="secondary">
                <Percentage
                    bind:x={data.Nose_Peak_Lenght.value}
                    bind:y={data.Nose_Bone_Height.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    bind:width_locale={$LOCALE.PEAKLENGTH_SUBTITLE}
                    bind:height_locale={$LOCALE.BONEHEIGHT_SUBTITLE}
                    on:change={() => {
                        APPEARANCE.setHeadStructure(data.Nose_Peak_Lenght);
                        APPEARANCE.setHeadStructure(data.Nose_Bone_Height);
                    }}
                />
            </svelte:fragment>
            <svelte:fragment slot="tertiary">
                <Percentage
                    bind:x={data.Nose_Peak_Lowering.value}
                    bind:y={data.Nose_Bone_Twist.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    bind:width_locale={$LOCALE.PEAKLOWERING_SUBTITLE}
                    bind:height_locale={$LOCALE.BONETWIST_SUBTITLE}
                    on:change={() => {
                        APPEARANCE.setHeadStructure(data.Nose_Peak_Lowering);
                        APPEARANCE.setHeadStructure(data.Nose_Bone_Twist);
                    }}
                />
            </svelte:fragment>
        </Wrapper>
    {/if}

    {#if data.EyeBrown_Height}
        <Wrapper label={$LOCALE.EYEBROW_TITLE}>
            <svelte:fragment slot="primary">
                <Percentage
                    bind:x={data.EyeBrown_Height.value}
                    bind:y={data.EyeBrown_Forward.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    bind:width_locale={$LOCALE.HEIGHT_SUBTITLE}
                    bind:height_locale={$LOCALE.DEPTH_SUBTITLE}
                    on:change={() => {
                        APPEARANCE.setHeadStructure(data.EyeBrown_Height);
                        APPEARANCE.setHeadStructure(data.EyeBrown_Forward);
                    }}
                />
            </svelte:fragment>
        </Wrapper>
    {/if}

    {#if data.Cheeks_Bone_High}
        <Wrapper label={$LOCALE.CHEEKS_TITLE}>
            <svelte:fragment slot="primary">
                <Percentage
                    bind:x={data.Cheeks_Bone_High.value}
                    bind:y={data.Cheeks_Bone_Width.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    bind:width_locale={$LOCALE.BONEHEIGHT_SUBTITLE}
                    bind:height_locale={$LOCALE.BONEWIDTH_SUBTITLE}
                    on:change={() => {
                        APPEARANCE.setHeadStructure(data.Cheeks_Bone_High);
                        APPEARANCE.setHeadStructure(data.Cheeks_Bone_Width);
                    }}
                />
            </svelte:fragment>

            <svelte:fragment slot="extra_primary-start">{$LOCALE.WIDTH_SUBTITLE}</svelte:fragment>
            <svelte:fragment slot="extra_primary">
                <Slider
                    bind:value={data.Cheeks_Width.value}
                    min={-1.0}
                    max={1.0}
                    step={0.01}
                    on:change={() =>
                        APPEARANCE.setHeadStructure(data.Cheeks_Width)}
                />
            </svelte:fragment>
        </Wrapper>

        {#if data.Eyes_Openning}
            <Wrapper label={$LOCALE.EYES_TITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.SQUINT_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="primary">
                    <Slider
                        bind:value={data.Eyes_Openning.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadStructure(data.Eyes_Openning)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="extra_primary">
                    <div
                        class="flex flex-col items-center justify-center w-full"
                    >
                        <span
                            class="opacity-75 w-full flex items-center justify-end gap-[0.5vh]"
                        >
                            <p>Colour</p>
                        </span>
                        <ColourDropdown
                            bind:index={eyeColor.value}
                            on:change={() => APPEARANCE.setEyeColor(eyeColor)}
                        />
                    </div>
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if data.Lips_Thickness}
            <Wrapper label={$LOCALE.LIPS_TITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.THICKNESS_SUBTITLE}</svelte:fragment
                >

                <svelte:fragment slot="primary">
                    <Slider
                        bind:value={data.Lips_Thickness.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadStructure(data.Lips_Thickness)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if data.Jaw_Bone_Width}
            <Wrapper label={$LOCALE.JAW_TITLE}>
                <svelte:fragment slot="primary">
                    <Percentage
                        bind:x={data.Jaw_Bone_Width.value}
                        bind:y={data.Jaw_Bone_Back_Lenght.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        bind:width_locale={$LOCALE.BONEWIDTH_SUBTITLE}
                        bind:height_locale={$LOCALE.BONELENGHT_SUBTITLE}
                        on:change={() => {
                            APPEARANCE.setHeadStructure(data.Jaw_Bone_Width);
                            APPEARANCE.setHeadStructure(data.Jaw_Bone_Back_Lenght);
                        }}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if data.Chin_Bone_Lowering}
            <Wrapper label={$LOCALE.CHIN_TITLE}>
                <svelte:fragment slot="primary">
                    <Percentage
                        bind:x={data.Chin_Bone_Lowering.value}
                        bind:y={data.Chin_Bone_Length.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        bind:width_locale={$LOCALE.BONELOWERING_SUBTITLE}
                        bind:height_locale={$LOCALE.BONELENGHT_SUBTITLE}
                        on:change={() => {
                            APPEARANCE.setHeadStructure(data.Chin_Bone_Lowering);
                            APPEARANCE.setHeadStructure(data.Chin_Bone_Length);
                        }}
                    />
                </svelte:fragment>
                <svelte:fragment slot="secondary">
                    <Percentage
                        bind:x={data.Chin_Bone_Width.value}
                        bind:y={data.Chin_Hole.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        bind:width_locale={$LOCALE.BONEWIDTH_SUBTITLE}
                        bind:height_locale={$LOCALE.HOLE_SUBTITLE}
                        on:change={() => {
                            APPEARANCE.setHeadStructure(data.Chin_Bone_Width);
                            APPEARANCE.setHeadStructure(data.Chin_Hole);
                        }}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if data.Neck_Thikness}
            <Wrapper label={$LOCALE.NECKTHICK_TITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.THICKNESS_SUBTITLE}</svelte:fragment
                >

                <svelte:fragment slot="primary">
                    <Slider
                        bind:value={data.Neck_Thikness.value}
                        min={-1.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadStructure(data.Neck_Thikness)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.Blemishes?.overlayValue !== null}
            <Wrapper label={$LOCALE.BLEMISHES_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.Blemishes.overlayValue}
                        total={headOverlayTotal.Blemishes}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Blemishes)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.Blemishes.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Blemishes)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.Ageing?.overlayValue !== null}
            <Wrapper label={$LOCALE.AGEING_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.Ageing.overlayValue}
                        total={headOverlayTotal.Ageing}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Blemishes)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.Ageing.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Ageing)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.Complexion?.overlayValue !== null}
            <Wrapper label={$LOCALE.COMPLEXION_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.Complexion.overlayValue}
                        total={headOverlayTotal.Complexion}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Complexion)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.Complexion.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.Complexion)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.SunDamage?.overlayValue !== null}
            <Wrapper label={$LOCALE.SUNDAMAGE_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.SunDamage.overlayValue}
                        total={headOverlayTotal.SunDamage}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.SunDamage)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.SunDamage.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.SunDamage)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.MolesFreckles?.overlayValue !== null}
            <Wrapper label={$LOCALE.MOLESFRECKLES_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.MolesFreckles.overlayValue}
                        total={headOverlayTotal.MolesFreckles}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.MolesFreckles)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.MolesFreckles.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.MolesFreckles)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}

        {#if headOverlay?.BodyBlemishes?.overlayValue !== null}
            <Wrapper label={$LOCALE.BODYBLEMISHES_SUBTITLE}>
                <svelte:fragment slot="primary-start">{$LOCALE.DESIGN_SUBTITLE}</svelte:fragment
                >
                <svelte:fragment slot="primary">
                    <NumberStepper
                        bind:value={headOverlay.BodyBlemishes.overlayValue}
                        total={headOverlayTotal.BodyBlemishes}
                        none={true}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.BodyBlemishes)}
                    />
                </svelte:fragment>

                <svelte:fragment slot="secondary-start">{$LOCALE.OPACITY_SUBTITLE}</svelte:fragment>

                <svelte:fragment slot="secondary">
                    <Slider
                        bind:value={headOverlay.BodyBlemishes.overlayOpacity}
                        min={0.0}
                        max={1.0}
                        step={0.01}
                        on:change={() =>
                            APPEARANCE.setHeadOverlay(headOverlay.BodyBlemishes)}
                    />
                </svelte:fragment>
            </Wrapper>
        {/if}
    {/if}
{/if}
