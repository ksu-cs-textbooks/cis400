---
title: "Templates"
pre: "6. "
weight: 60
date: 2018-08-24T10:53:26-05:00
---

Most WPF controls are themselves composed of multiple, simpler, controls. For example, a `<Button>` is composed of a `<Border>` and whatever content you place inside the button.  A simplified version of this structure appears below (I removed the styling information and the `VisualState` components responsible for presenting the button differently when it is enabled, disabled, hovered on, or clicked):

```xml
<Border TextBlock.Foreground="{TemplateBinding Foreground}"
        x:Name="Border"
        CornerRadius="2"
        BorderThickness="1">
  <Border.BorderBrush>
    <LinearGradientBrush StartPoint="0,0"
                          EndPoint="0,1">
      <LinearGradientBrush.GradientStops>
        <GradientStopCollection>
          <GradientStop Color="{DynamicResource BorderLightColor}"
                        Offset="0.0" />
          <GradientStop Color="{DynamicResource BorderDarkColor}"
                        Offset="1.0" />
        </GradientStopCollection>
      </LinearGradientBrush.GradientStops>
    </LinearGradientBrush>
  </Border.BorderBrush>
  <Border.Background>
    <LinearGradientBrush EndPoint="0.5,1"
                          StartPoint="0.5,0">
      <GradientStop Color="{DynamicResource ControlLightColor}"
                    Offset="0" />
      <GradientStop Color="{DynamicResource ControlMediumColor}"
                    Offset="1" />
    </LinearGradientBrush>
  </Border.Background>
  <ContentPresenter Margin="2"
                    HorizontalAlignment="Center"
                    VerticalAlignment="Center"
                    RecognizesAccessKey="True" />
</Border>
```

This has some implications for working with the control - for example, if you wanted to add rounded corners to the `<Button>`, they would actually need to be added to the `<Border>` _inside_ the button.  This can be done by nesting styles, i.e.:

```xml
<Grid>
    <Grid.Resources>
        <Style TargetType="Button">
            <Style.Resources>
                <Style TargetType="Border">
                    <Setter Property="CornerRadius" Value="25"/>
                </Style>
            </Style.Resources>
        </Style>
    </Grid.Resources>
    <Button>I have rounded corners now!</Button>
</Grid>
```

Note how the `<Style>` targeting the `<Border>` is _nested inside the `Resources`_ of the `<Style>` targeting the `<Button>`?  This means that the style rules for the `<Border>` will only be applied to `<Border>` elements that are part of a `<Button>`.


### Templates
Above I listed a simplified version of the XAML used to create a button.  The full listing can be found <a href="https://docs.microsoft.com/en-us/dotnet/desktop/wpf/controls/button-styles-and-templates?view=netframeworkdesktop-4.8#button-controltemplate-example" target="_blank">in the Microsoft Documentation</a>

What's more, you can _replace_ this standard rendering in your controls by replacing the `Template` property.  For example, we could replace our button with a super-simple rounded `<Border>` that nested a `<TextBlock>` that does word-wrapping of the button content:

```xml
<Button>
    <Button.Template>
        <ControlTemplate>
            <Border CornerRadius="25">
                <TextBlock TextWrapping="Wrap">  
                    <ContentPresenter Margin="2"
                        HorizontalAlignment="Center"
                        VerticalAlignment="Center"
                        RecognizesAccessKey="True" />
                </TextBlock>
            </Border>
        </ControlTemplate>
    </Button.ControlTemplate>
    This is a simple button!
</Button>
```

The `<ContentPresenter>` is what presents the _content_ nested inside the button - in this case, the text `This is a simple button!`.  Of course, this super-simple button will not change its appearance when you hover over it or click it, or when it is disabled.  But it helps convey the idea of a `<ControlTemplate>`.  As with any other property, you can also set the `Template` property of a control using a `<Setter>` within a `<Style>` targeting that element.

If you only need a simple tweak - like applying word-wrapping to the text of a button, it often makes more sense to supply as content a control that will do so, i.e.:

```csharp
<Button>
    <TextBlock TextWrapping="Wrap">
        I also wrap text!
    </TextBlock>
</Button>
```

This allows the `<Button>` to continue to use the default `ControlTemplate` while providing the desired word-wrapping with a minimum of extra code.  

A similar idea appears with `<DataTemplate>`, which allows you to customize how bound data is displayed in a control.  For example, we often want to display the items in a `<ListBox>` in a different way than the default (a `<TextBlock>` with minimal styling).  We'll visit this in the upcoming [binding lists]({{% ref "2-desktop-development/04-data-binding/04-binding-lists" %}}) section.

